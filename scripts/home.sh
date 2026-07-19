#!/usr/bin/env zsh
# AntaresOS · home — dashboard da sessão work (fastfetch + git dos repos + TODOs)

emulate -L zsh
setopt no_nomatch

# repos acompanhados: "rótulo:caminho"
local -a REPOS=(
  "foodbot-app:$HOME/Foodbot/foodbot-app"
  "foodbot-service:$HOME/Foodbot/foodbot-service"
  "foodbot-antares:$HOME/Foodbot/foodbot-antares"
  "courthub:$HOME/Github/CourtHub"
  "antares-os:$HOME/Github/AntaresOS"
)

_repo_line() {
  local name="$1" dir="$2"
  if ! git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
    printf "   %-16s %s\n" "$name" "—"
    return
  fi
  local branch dirty ahead=0 behind=0 ab
  branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null)
  dirty=$(git -C "$dir" status --porcelain 2>/dev/null | grep -c .)
  if ab=$(git -C "$dir" rev-list --left-right --count HEAD...@{u} 2>/dev/null); then
    ahead=${ab%%[[:space:]]*}; behind=${ab##*[[:space:]]}
  fi
  local state
  if (( dirty == 0 )); then state="%F{green}✓ limpo%f"; else state="%F{yellow}● ${dirty} alt%f"; fi
  print -P "   %F{cyan}${(r:16:)name}%f %F{green}${(r:14:)branch}%f ${state}  %F{green}↑%f${ahead} %F{red}↓%f${behind}"
}

clear
if command -v fastfetch &>/dev/null; then
  fastfetch --logo-type small 2>/dev/null || fastfetch
fi

print -P "%F{green}╭─ REPOS ─────────────────────────────────────────────╮%f"
local entry
for entry in "${REPOS[@]}"; do
  _repo_line "${entry%%:*}" "${entry#*:}"
done
print -P "%F{green}╰─────────────────────────────────────────────────────╯%f"

# TODOs recentes do inbox
local inbox="${ANTARES_LIB:-$HOME/Github/AntaresOS/library}/notes/inbox.md"
print -P "\n%F{green} TODO (note \"...\")%f"
local todos
todos=$(grep -E '^- ' "$inbox" 2>/dev/null | tail -5)
if [[ -n "$todos" ]]; then
  print "$todos" | sed 's/^/   /'
else
  print -P "   %F{8}(vazio — capture com: note \"sua tarefa\")%f"
fi
print ""
