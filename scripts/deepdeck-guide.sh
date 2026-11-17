#!/usr/bin/env bash
# deepdeck-guide — the GUIA pane next to nvim: shows docs/guia-nvim.txt with the Deepdeck colours.
# Scroll with j/k, the arrows or the mouse; q draws it again for the new pane width (the pane does not close).
set -u
DIR=$(cd "$(dirname "$0")/.." && pwd)
# shellcheck source=deepdeck-lib.sh
. "$DIR/scripts/deepdeck-lib.sh"
GUIDE=${DEEPDECK_GUIDE:-$DIR/docs/guia-nvim.txt}

render() {
    local width=$(( $(tput cols 2>/dev/null || echo 40) - 13 ))
    [ "$width" -lt 12 ] && width=12
    awk -v width="$width" -v M="$DD_M$DD_B" -v C="$DD_C" -v W="$DD_W" -v D="$DD_D" -v R="$DD_R" '
        /^# / || /^#$/ || /^$/ { next }
        /^## / { sub(/^## /, ""); printf "\n%s%s%s\n", M, $0, R; next }
        /\|/ {
            i = index($0, "|"); k = substr($0, 1, i - 1); t = substr($0, i + 1)
            sub(/ +$/, "", k); sub(/^ +/, "", t)
            n = split(t, w, " "); line = ""; first = 1
            for (j = 1; j <= n; j++) {
                if (line != "" && length(line) + 1 + length(w[j]) > width) {
                    printf " %s%-10s%s %s%s%s\n", C, (first ? k : ""), R, W, line, R; first = 0; line = w[j]
                } else line = (line == "" ? w[j] : line " " w[j])
            }
            printf " %s%-10s%s %s%s%s\n", C, (first ? k : ""), R, W, line, R; next
        }
        { print }
    ' "$GUIDE"
    printf '\n%s j/k rolar · q topo · Opt+g esconder%s\n' "$DD_D" "$DD_R"
}

while :; do
    render | less -R -~ --mouse -P ' ' 2>/dev/null || render
    clear
done
