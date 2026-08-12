#!/usr/bin/env zsh
# workspace-init.sh — inicializa um pane de projeto com navegação interativa

setopt NO_NOMATCH 2>/dev/null

_cyan='\033[38;2;125;207;255m'
_purple='\033[38;2;187;154;247m'
_reset='\033[0m'

echo ""
printf "${_cyan}  󰚩 Workspace${_reset}\n"
echo ""
printf "${_purple}  Caminho do projeto${_reset} (Enter = ~): "
read proj

proj=${proj:-$HOME}
proj="${proj/#\~/$HOME}"

if [[ ! -d "$proj" ]]; then
    echo "  dir não encontrado — usando ~"
    proj=$HOME
fi

cd "$proj"

tab_name=$(basename "$proj")
zellij action rename-tab "󰚩 $tab_name" 2>/dev/null

echo ""
claude --continue
