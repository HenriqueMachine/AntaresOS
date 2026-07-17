#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  LabOS · update.sh — atualiza o ambiente
#  git pull → brew bundle → restow → plugins
# ═══════════════════════════════════════════════════════════════
set -euo pipefail

LABOS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LABOS_DIR
source "$LABOS_DIR/scripts/lib.sh"

step "Atualizando o LabOS"

info "Puxando as últimas mudanças do repositório…"
git -C "$LABOS_DIR" pull --ff-only || warn "git pull falhou (mudanças locais?)"

bash "$LABOS_DIR/scripts/10-brew-bundle.sh"
bash "$LABOS_DIR/scripts/20-stow.sh"

step "Neovim"
if have nvim; then
  nvim --headless "+Lazy! sync" +qa 2>/dev/null && ok "plugins atualizados" \
    || warn "abra o nvim para concluir a atualização dos plugins"
fi

info "Atualizando o Homebrew em si…"
brew update >/dev/null 2>&1 && brew upgrade >/dev/null 2>&1 && ok "Homebrew atualizado" || true

ok "LabOS atualizado. Rode 'reload' para recarregar o shell."
