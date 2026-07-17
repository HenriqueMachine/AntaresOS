#!/usr/bin/env bash
# AntaresOS · 40 — baixa os plugins WASM do Zellij (versões fixadas)
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Plugins do Zellij"

DIR="$HOME/.config/zellij/plugins"
mkdir -p "$DIR"

# nome  url
plugins=(
  "zjstatus.wasm|https://github.com/dj95/zjstatus/releases/download/v0.24.0/zjstatus.wasm"
  "zellij-autolock.wasm|https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm"
)

for entry in "${plugins[@]}"; do
  name="${entry%%|*}"; url="${entry##*|}"
  if [[ -f "$DIR/$name" ]]; then
    ok "$name já presente"
  else
    info "baixando $name…"
    if curl -fsSL -o "$DIR/$name" "$url"; then
      ok "$name baixado"
    else
      warn "não consegui baixar $name ($url)"
    fi
  fi
done
