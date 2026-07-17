#!/usr/bin/env bash
# AntaresOS · 10 — brew bundle
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Programas (brew bundle)"

if ! have brew; then
  err "Homebrew não encontrado — rode o 00-homebrew.sh primeiro."
  exit 1
fi

info "Resolvendo o Brewfile (isso pode demorar na primeira vez)…"
brew bundle install --file="$ANTARES_DIR/Brewfile" --no-upgrade
ok "Programas do Brewfile instalados/atualizados"
