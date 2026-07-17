# AntaresOS · library.zsh

export ANTARES_LIB="${ANTARES_DIR:-$HOME/Github/AntaresOS}/library"
export NAVI_PATH="$ANTARES_LIB/cheats"

if command -v navi >/dev/null 2>&1 && [[ -o interactive && -t 1 ]]; then
  eval "$(navi widget zsh)"
fi

lib() { nvim "$ANTARES_LIB"; }

note() {
  local f="$ANTARES_LIB/notes/inbox.md"
  mkdir -p "${f:h}"
  if [[ -z "$*" ]]; then nvim "$f"; return; fi
  printf -- '- %s — %s\n' "$(date '+%Y-%m-%d %H:%M')" "$*" >> "$f"
  print "anotado ✓ ($f)"
}
