#!/usr/bin/env bash
# deepdeck-panel — the PAINEL tab, in two columns (user decision 17/11):
#   left:  AGENTES (vault 11-Agentes, emoji and colour from Identidade.md) and DIÁRIO (13-Diario of today)
#   right: MÁQUINA (heavy lanes), PRs ABERTOS (cache 2 min), TOKENS HOJE (ccusage)
# Refreshes every DEEPDECK_PANEL_SECONDS (default 20). Read only. `--once` draws one time (for tests).
set -uo pipefail
# shellcheck source=deepdeck-lib.sh
. "$(dirname "$0")/deepdeck-lib.sh"

HEAVY=$FOODBOT_ROOT/foodbot-ops/bin/heavy
EVERY=${DEEPDECK_PANEL_SECONDS:-20}
CACHE=${TMPDIR:-/tmp}/deepdeck-panel
mkdir -p "$CACHE"
M=$DD_M; C=$DD_C; Y=$DD_Y; G=$DD_G; W=$DD_W; D=$DD_D; B=$DD_B; R=$DD_R

# Cut a plain string to n characters.
cutn() { local s=$1 n=$2; [ ${#s} -le "$n" ] && printf '%s' "$s" || printf '%s…' "${s:0:$((n-1))}"; }

head_line() { # title, hint, width
    local t=" $1 " h=${2:+ $2 } w=$3 rest
    rest=$(( w - ${#t} - ${#h} - 1 ))
    [ $rest -lt 0 ] && rest=0
    printf '%s%s┌%s%s%s%s%s%s\n' "$M" "$B" "$t" "$R" "$D" "$h" "$(printf '─%.0s' $(seq 1 $rest))" "$R"
}

agents() { # width
    local w=$1 today f name st task upd col
    today=$(date +%Y-%m-%d)
    for f in "$DD_VAULT"/11-Agentes/*.md; do
        name=$(basename "$f" .md)
        case $name in README|Arquitetura-Agentes|Protocolo-Comunicacao|Deepdeck|00-Indice-Agentes|Identidade) continue ;; esac
        st=$(awk -F': *' '/^---$/{n++; next} n==1 && $1=="status"{gsub(/"/,"",$2); print $2; exit}' "$f")
        task=$(awk '/^---$/{n++; next} n==1 && /^tarefa:/{sub(/^tarefa: */,""); gsub(/"/,""); print; exit}' "$f")
        upd=$(awk -F': *' '/^---$/{n++; next} n==1 && $1=="atualizado"{gsub(/"/,"",$2); print $2; exit}' "$f")
        dd_who "$name"
        case $st in
            *bloq*|*block*) col=$Y ;;
            *andamento*|*working*|*ativo*|*revis*) col=$G ;;
            *) col=$C ;;
        esac
        [ "$upd" = "$today" ] || { col=$D; DD_COLOR=$D; }
        printf '%s %s%s%-12s%s %s%-12s%s %s\n' "$DD_EMOJI" "$DD_COLOR" "$B" "$(cutn "$name" 12)" "$R" \
            "$col" "$(cutn "${st:-—}" 12)" "$R" "$(cutn "$task" $(( w - 30 )))"
    done
}

diary() { # width
    local w=$1 f line who
    f=$DD_VAULT/13-Diario/$(TZ=America/Sao_Paulo date +%Y-%m-%d).md
    [ -f "$f" ] || { echo "${D}sem registro hoje${R}"; return; }
    grep -E '^- ' "$f" | tail -n 8 | sed -E 's/\*\*//g; s/^- //' | while IFS= read -r line; do
        who=$(grep -oE '\[\[[^]|]+' <<<"$line" | head -1 | sed 's/\[\[//')
        line=$(sed -E 's/\[\[([^]|]*)(\|[^]]*)?\]\]/\1/g' <<<"$line")
        dd_who "${who:-x}"
        printf '%s %s%s%s\n' "$DD_EMOJI" "$DD_COLOR" "$(cutn "$line" $(( w - 4 )))" "$R"
    done
}

machine() { # width
    local w=$1 st h q f
    [ -x "$HEAVY" ] || { echo "${D}heavy não encontrado${R}"; return; }
    st=$("$HEAVY" --status 2>/dev/null)
    h=$(grep -cE '^heavy slot[0-9]+: pid' <<<"$st"); q=$(grep -cE '^quick quick[0-9]+: pid' <<<"$st")
    f=$(grep -cE ' queue [0-9]+:' <<<"$st")
    bar() { [ "$1" -gt 0 ] && printf '%s▓▓%s' "$G" "$R" || printf '%s░░%s' "$D" "$R"; }
    printf 'heavy  %s %s/1    quick  %s %s/1    %sfila %s%s\n' "$(bar "$h")" "$h" "$(bar "$q")" "$q" "$([ "$f" -gt 0 ] && echo "$Y" || echo "$D")" "$f" "$R"
    grep -E '^(heavy|quick) [a-z]+[0-9]+: pid| queue [0-9]+:' <<<"$st" | sed -E 's/ \(\/Users[^)]*\)$//; s/pid [0-9]+ since //; s/\/Users\/[^ ]*\///g' |
        while IFS= read -r l; do
            case $l in *queue*) printf '%s%s%s\n' "$Y" "$(cutn "$l" "$w")" "$R" ;; *) printf '%s%s%s\n' "$W" "$(cutn "$l" "$w")" "$R" ;; esac
        done
}

prs() { # width
    local w=$1 f=$CACHE/prs.txt r
    if [ ! -f "$f" ] || [ $(( $(date +%s) - $(stat -f %m "$f") )) -gt 120 ]; then
        : > "$f.new"
        for r in foodbot-service foodbot-app foodbot-ops; do
            gh pr list -R "HenriqueMachine/$r" --state open --limit 20 --json number,title,isDraft \
                --jq ".[] | \"${r#foodbot-}|#\(.number)|\(if .isDraft then \"d\" else \"o\" end)|\(.title)\"" >> "$f.new" 2>/dev/null
        done
        mv "$f.new" "$f"
    fi
    [ -s "$f" ] || { echo "${D}nenhum PR aberto${R}"; return; }
    while IFS='|' read -r repo num kind title; do
        s=$W; [ "$kind" = d ] && s=$D
        printf '%s%-7s%s %s%-6s %s%s\n' "$C" "$repo" "$R" "$s" "$num" "$(cutn "$title" $(( w - 16 )))" "$R"
    done < "$f"
}

tokens() {
    if command -v ccusage >/dev/null 2>&1; then
        ccusage daily --since "$(date +%Y%m%d)" --json 2>/dev/null |
            jq -r '.totals // .daily[-1] | "\(.totalTokens // 0) tokens · US$ \((.totalCost // 0) * 100 | round / 100)"' 2>/dev/null ||
            echo "${D}ccusage: sem dados${R}"
    else
        echo "${D}ccusage não instalado${R}"
    fi
}

# Prints lines at column $1, from row $2; returns the next free row in NEXT_ROW.
place() {
    local col=$1 row=$2 line
    while IFS= read -r line; do
        printf '\e[%d;%dH%s' "$row" "$col" "$line"
        row=$((row + 1))
    done
    NEXT_ROW=$row
}

draw() {
    local cols rows lw rw rc row
    cols=${DEEPDECK_COLS:-$(tput cols 2>/dev/null || echo 120)}; rows=${DEEPDECK_ROWS:-$(tput lines 2>/dev/null || echo 40)}
    lw=$(( cols * 58 / 100 )); rw=$(( cols - lw - 3 )); rc=$(( lw + 3 ))
    local L1 L2 R1 R2 R3
    L1=$(agents "$lw"); L2=$(diary "$lw"); R1=$(machine "$rw"); R2=$(prs "$rw"); R3=$(tokens)
    printf '\e[H\e[2J'
    printf '\e[1;1H%s%s▓▒░ DEEPDECK %s%s· FoodBot%s' "$M" "$B" "$R" "$C" "$R"
    printf '\e[1;%dH%s%s%s%s' "$(( cols - 5 ))" "$Y" "$B" "$(date '+%H:%M')" "$R"
    row=3
    place 1 $row < <(head_line "AGENTES" "cinza = sem atualização hoje" "$lw"); row=$NEXT_ROW
    place 2 $row <<<"$L1"; row=$((NEXT_ROW + 1))
    place 1 $row < <(head_line "DIÁRIO" "hoje" "$lw"); row=$NEXT_ROW
    place 2 $row <<<"$L2"
    row=3
    place "$rc" $row < <(head_line "MÁQUINA" "" "$rw"); row=$NEXT_ROW
    place $((rc + 1)) $row <<<"$R1"; row=$((NEXT_ROW + 1))
    place "$rc" $row < <(head_line "PRs ABERTOS" "cache 2 min" "$rw"); row=$NEXT_ROW
    place $((rc + 1)) $row <<<"$R2"; row=$((NEXT_ROW + 1))
    place "$rc" $row < <(head_line "TOKENS HOJE" "" "$rw"); row=$NEXT_ROW
    place $((rc + 1)) $row <<<"$R3"
    printf '\e[%d;1H%s atualiza a cada %ss · q sai%s' "$rows" "$D" "$EVERY" "$R"
}

if [ "${1:-}" = "--once" ]; then draw; printf '\n'; exit 0; fi
trap 'printf "\e[?25h"; exit 0' INT TERM
printf '\e[?25l'
while true; do
    draw
    if read -r -s -n 1 -t "$EVERY" key && [ "$key" = q ]; then printf '\e[?25h'; exit 0; fi
done
