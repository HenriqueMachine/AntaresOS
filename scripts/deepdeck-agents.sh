#!/usr/bin/env bash
# deepdeck-agents — the AGENTES tab: pick a Runeterra agent and start it, or resume an old session.
#   Enter   start a new session as that agent (foodbot-ops/bin/agent <name>)
#   Ctrl-R  resume a session of that agent (claude --resume, the picker of Claude Code)
#   Esc     quit
# After the session ends, the menu comes back.
set -uo pipefail
# shellcheck source=deepdeck-lib.sh
. "$(dirname "$0")/deepdeck-lib.sh"

ROOT=${FOODBOT_ROOT:-$HOME/Foodbot}
AGENTS_DIR=$ROOT/.claude/agents
AGENT_BIN=$ROOT/foodbot-ops/bin/agent

list() {
  local f name model desc
  for f in "$AGENTS_DIR"/*.md; do
    name=$(basename "$f" .md)
    model=$(awk -F': *' '/^---$/{n++; next} n==1 && $1=="model"{print $2; exit}' "$f")
    desc=$(awk -F': *' '/^---$/{n++; next} n==1 && $1=="description"{sub(/^description: */,""); gsub(/"/,""); print; exit}' "$f")
    dd_who "$name"
    [ "$DD_EMOJI" = "·" ] && continue   # only the Runeterra agents of Identidade.md
    printf '%s %s%-13s%s %s%-7s%s %s\n' "$DD_EMOJI" "$DD_COLOR$DD_B" "$name" "$DD_R" "$DD_D" "${model:-?}" "$DD_R" "$desc"
  done
}

command -v fzf >/dev/null || { echo "deepdeck-agents: fzf is not installed (brew install fzf)" >&2; exit 1; }
[ -d "$AGENTS_DIR" ] || { echo "deepdeck-agents: $AGENTS_DIR not found" >&2; exit 1; }

while true; do
  out=$(list | fzf --ansi --reverse --no-sort --prompt 'agente › ' \
    --header $'Enter: nova sessão · Ctrl-R: retomar · Esc: sair' \
    --expect ctrl-r \
    --color 'fg:#f5f5f5,bg:#000000,hl:#05d9e8,fg+:#000000,bg+:#ff2a6d,hl+:#f9f002,prompt:#ff2a6d,pointer:#f9f002,header:#5c5c70,border:#ff2a6d' \
    --border rounded --border-label ' DEEPDECK · AGENTES ') || exit 0
  key=$(sed -n 1p <<<"$out")
  name=$(sed -n 2p <<<"$out" | awk '{print $2}')
  [ -n "$name" ] || exit 0
  clear
  if [ "$key" = ctrl-r ]; then
    "$AGENT_BIN" "$name" --resume
  else
    "$AGENT_BIN" "$name"
  fi
done
