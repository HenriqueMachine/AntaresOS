#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  LabOS · 10 — instala tudo do Brewfile
# ═══════════════════════════════════════════════════════════════
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Programas (brew bundle)"

if ! have brew; then
  err "Homebrew não encontrado — rode o 00-homebrew.sh primeiro."
  exit 1
fi

info "Resolvendo o Brewfile (isso pode demorar na primeira vez)…"
brew bundle --file="$LABOS_DIR/Brewfile" --no-lock
ok "Programas do Brewfile instalados/atualizados"
