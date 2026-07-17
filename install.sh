#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#
#   ██╗      █████╗ ██████╗  ██████╗ ███████╗
#   ██║     ██╔══██╗██╔══██╗██╔═══██╗██╔════╝
#   ██║     ███████║██████╔╝██║   ██║███████╗
#   ██║     ██╔══██║██╔══██╗██║   ██║╚════██║
#   ███████╗██║  ██║██████╔╝╚██████╔╝███████║
#   ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚══════╝
#
#   Estação de trabalho keyboard-driven, componível e persistente.
#   Uso:  ./install.sh            (tudo)
#         ./install.sh --dotfiles (só os symlinks, sem instalar programas)
# ═══════════════════════════════════════════════════════════════
set -euo pipefail

LABOS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LABOS_DIR
source "$LABOS_DIR/scripts/lib.sh"

printf '%s' "$C_MAUVE"
cat <<'BANNER'
   ┌─────────────────────────────────────────┐
   │   LabOS 🔬  ·  instalando seu ambiente   │
   └─────────────────────────────────────────┘
BANNER
printf '%s' "$C_RESET"

MODE="${1:-full}"

case "$MODE" in
  --dotfiles)
    info "Modo: apenas dotfiles (stow)"
    bash "$LABOS_DIR/scripts/20-stow.sh"
    ;;
  full|"")
    bash "$LABOS_DIR/scripts/00-homebrew.sh"
    bash "$LABOS_DIR/scripts/10-brew-bundle.sh"
    bash "$LABOS_DIR/scripts/20-stow.sh"
    bash "$LABOS_DIR/scripts/30-post.sh"
    ;;
  *)
    err "Modo desconhecido: $MODE  (use: full | --dotfiles)"
    exit 1
    ;;
esac

step "Pronto! 🎉"
cat <<EOF
  Seu LabOS está montado. Próximos passos:

    ${C_BLUE}1.${C_RESET} Abra um novo terminal (Ghostty) — o Zellij sobe sozinho.
    ${C_BLUE}2.${C_RESET} Rode ${C_GREEN}dev${C_RESET} para o layout editor + terminal + Claude Code.
    ${C_BLUE}3.${C_RESET} Rode ${C_GREEN}flutter doctor${C_RESET} para conferir o toolchain mobile.

  Atualizar no futuro:  ${C_GREEN}labos-update${C_RESET}  (ou ./update.sh)
EOF
