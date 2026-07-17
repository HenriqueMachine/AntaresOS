# AntaresOS · codex.zsh

alias codex-build='bash "${ANTARES_DIR:-$HOME/Github/AntaresOS}/scripts/codex-build.sh"'

# busca no Codex (fzf) e copia o snippet pro clipboard
snip() {
  local idx="${ANTARES_LIB:-$HOME/Github/AntaresOS/library}/codex/.build/index.json"
  if [[ ! -f "$idx" ]]; then print "Codex ainda não gerado — rode 'codex-build'"; return 1; fi
  command -v fzf >/dev/null 2>&1 || { print "fzf não encontrado"; return 1; }
  command -v jq  >/dev/null 2>&1 || { print "jq não encontrado"; return 1; }

  local pick trig
  pick=$(jq -r '.[] | "\(.lang)\t\(.trigger)\t\(.title)"' "$idx" \
    | fzf --delimiter='\t' --with-nth=1,2,3 --prompt='codex ❯ ' \
        --preview "jq -r --arg t {2} '.[] | select(.trigger==\$t) | \"# \(.title)  ·  \(.lang)  ·  \(.tags)\n\n\(.description)\n\n\(.body)\"' $idx | bat --language=md --color=always --style=plain --paging=never") || return
  [[ -z "$pick" ]] && return
  trig=$(cut -f2 <<< "$pick")
  jq -r --arg t "$trig" '.[] | select(.trigger==$t) | .body' "$idx" | pbcopy
  print "copiado ✓ ($trig) — cole com ⌘V"
}
