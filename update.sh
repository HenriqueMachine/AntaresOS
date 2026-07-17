#!/usr/bin/env bash
# AntaresOS · update.sh
set -euo pipefail

ANTARES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ANTARES_DIR
source "$ANTARES_DIR/scripts/lib.sh"

step "Updating AntaresOS"

info "Pulling latest changes…"
git -C "$ANTARES_DIR" pull --ff-only || warn "git pull falhou (mudanças locais?)"

bash "$ANTARES_DIR/scripts/10-brew-bundle.sh"
bash "$ANTARES_DIR/scripts/20-stow.sh"

bash "$ANTARES_DIR/scripts/40-zellij-plugins.sh"

step "Codex"
bash "$ANTARES_DIR/scripts/codex-build.sh" || warn "não consegui gerar o Codex"

step "Neovim"
if have nvim; then
  nvim --headless "+Lazy! sync" +qa 2>/dev/null && ok "plugins atualizados" \
    || warn "abra o nvim para concluir a atualização dos plugins"
fi

info "Updating Homebrew…"
brew update >/dev/null 2>&1 && brew upgrade >/dev/null 2>&1 && ok "Homebrew atualizado" || true

ok "AntaresOS atualizado. Rode 'reload' para recarregar o shell."
