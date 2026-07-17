#!/usr/bin/env bash
#
#    █████╗ ███╗   ██╗████████╗ █████╗ ██████╗ ███████╗███████╗
#   ██╔══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██╔════╝
#   ███████║██╔██╗ ██║   ██║   ███████║██████╔╝█████╗  ███████╗
#   ██╔══██║██║╚██╗██║   ██║   ██╔══██║██╔══██╗██╔══╝  ╚════██║
#   ██║  ██║██║ ╚████║   ██║   ██║  ██║██║  ██║███████╗███████║
#   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
#
#   Usage:  ./install.sh            (full)
#           ./install.sh --dotfiles (symlinks only)
#
set -euo pipefail

ANTARES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ANTARES_DIR
source "$ANTARES_DIR/scripts/lib.sh"

printf '%s' "$C_GREEN"
cat <<'BANNER'
   ┌───────────────────────────────────────────────┐
   │   AntaresOS ✦  ·  setting up your workspace     │
   └───────────────────────────────────────────────┘
BANNER
printf '%s' "$C_RESET"

MODE="${1:-full}"

case "$MODE" in
  --dotfiles)
    info "Mode: dotfiles only (stow)"
    bash "$ANTARES_DIR/scripts/20-stow.sh"
    ;;
  full|"")
    bash "$ANTARES_DIR/scripts/00-homebrew.sh"
    bash "$ANTARES_DIR/scripts/10-brew-bundle.sh"
    bash "$ANTARES_DIR/scripts/20-stow.sh"
    bash "$ANTARES_DIR/scripts/30-post.sh"
    ;;
  *)
    err "Unknown mode: $MODE  (use: full | --dotfiles)"
    exit 1
    ;;
esac

step "Done ✦"
cat <<EOF
  Your AntaresOS is ready. Next steps:

    ${C_BLUE}1.${C_RESET} Open a new terminal (Ghostty).
    ${C_BLUE}2.${C_RESET} Run ${C_GREEN}dev${C_RESET} for the editor + terminal + Claude Code layout.
    ${C_BLUE}3.${C_RESET} Run ${C_GREEN}flutter doctor${C_RESET} to check the mobile toolchain.

  Update later:  ${C_GREEN}antares-update${C_RESET}  (or ./update.sh)
EOF
