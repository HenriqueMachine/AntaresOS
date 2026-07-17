#!/usr/bin/env bash
# AntaresOS · lib.sh — helpers
set -euo pipefail

ANTARES_DIR="${ANTARES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
export ANTARES_DIR

if [[ -t 1 ]]; then
  C_RESET=$'\e[0m'; C_MAUVE=$'\e[38;5;46m'; C_GREEN=$'\e[38;5;42m'
  C_YELLOW=$'\e[38;5;222m'; C_RED=$'\e[38;5;203m'; C_BLUE=$'\e[38;5;44m'
  C_DIM=$'\e[38;5;65m'
else
  C_RESET=''; C_MAUVE=''; C_GREEN=''; C_YELLOW=''; C_RED=''; C_BLUE=''; C_DIM=''
fi

step()  { printf '\n%s▸ %s%s\n'   "$C_MAUVE" "$*" "$C_RESET"; }
info()  { printf '%s  · %s%s\n'   "$C_DIM"   "$*" "$C_RESET"; }
ok()    { printf '%s  ✓ %s%s\n'   "$C_GREEN" "$*" "$C_RESET"; }
warn()  { printf '%s  ! %s%s\n'   "$C_YELLOW" "$*" "$C_RESET"; }
err()   { printf '%s  ✗ %s%s\n'   "$C_RED"   "$*" "$C_RESET" >&2; }

have()  { command -v "$1" >/dev/null 2>&1; }
