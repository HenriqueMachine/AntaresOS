#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  LabOS · 00 — garante o Homebrew instalado
# ═══════════════════════════════════════════════════════════════
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Homebrew"

if have brew; then
  ok "Homebrew já instalado ($(brew --version | head -1))"
else
  info "Instalando o Homebrew…"
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ok "Homebrew instalado"
fi

# Garante o brew no PATH da sessão atual (Apple Silicon / Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
