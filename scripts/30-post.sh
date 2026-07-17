#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  LabOS · 30 — pós-instalação (frameworks, agente, identidade)
# ═══════════════════════════════════════════════════════════════
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

# ── Oh My Zsh ───────────────────────────────────────────────────
step "Oh My Zsh"
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  ok "Oh My Zsh já presente"
else
  info "Instalando Oh My Zsh (sem trocar o shell nem abrir zsh)…"
  RUNZSH=no KEEP_ZSHRC=yes CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ok "Oh My Zsh instalado"
fi

# ── zsh como shell padrão ───────────────────────────────────────
step "Shell padrão"
BREW_ZSH="$(brew --prefix 2>/dev/null)/bin/zsh"
if [[ "$SHELL" != *zsh ]]; then
  warn "Shell atual não é zsh. Para trocar: chsh -s $(command -v zsh)"
else
  ok "zsh já é o shell padrão"
fi

# ── fvm (gerenciador de versões do Flutter) ─────────────────────
step "fvm (Flutter)"
if have fvm; then
  ok "fvm já instalado ($(fvm --version 2>/dev/null))"
elif have dart; then
  info "Instalando fvm via dart pub global…"
  dart pub global activate fvm || warn "não consegui instalar o fvm agora"
else
  warn "dart/flutter ainda não disponível — instale o fvm depois com: dart pub global activate fvm"
fi

# ── Claude Code (agente de IA) ──────────────────────────────────
step "Claude Code"
if have claude; then
  ok "Claude Code já instalado"
else
  info "Instalando Claude Code…"
  if curl -fsSL https://claude.ai/install.sh | bash; then
    ok "Claude Code instalado"
  elif have npm; then
    npm install -g @anthropic-ai/claude-code && ok "Claude Code instalado (npm)"
  else
    warn "Não consegui instalar o Claude Code automaticamente. Veja: https://claude.com/claude-code"
  fi
fi

# ── Tema Catppuccin para o bat/delta ────────────────────────────
step "Tema Catppuccin (bat/delta)"
BAT_THEME_DIR="$(bat --config-dir 2>/dev/null)/themes"
if have bat && [[ ! -f "$BAT_THEME_DIR/Catppuccin Mocha.tmTheme" ]]; then
  mkdir -p "$BAT_THEME_DIR"
  if curl -fsSL -o "$BAT_THEME_DIR/Catppuccin Mocha.tmTheme" \
      "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme"; then
    bat cache --build >/dev/null 2>&1 && ok "tema Catppuccin Mocha instalado no bat"
  else
    warn "não consegui baixar o tema do bat (delta cairá no tema padrão)"
  fi
else
  have bat && ok "tema do bat já presente"
fi

# ── Identidade do git (NÃO versionada) ──────────────────────────
step "Identidade do git (~/.gitconfig.local)"
if [[ -f "$HOME/.gitconfig.local" ]]; then
  ok "~/.gitconfig.local já existe — mantendo"
else
  # Aproveita valores atuais como sugestão, se existirem.
  cur_name="$(git config --global user.name 2>/dev/null || true)"
  cur_email="$(git config --global user.email 2>/dev/null || true)"
  if [[ -t 0 ]]; then
    printf '  Nome para os commits [%s]: ' "${cur_name:-Henrique Paixão}"
    read -r in_name
    printf '  Email para os commits [%s]: ' "${cur_email:-}"
    read -r in_email
  fi
  name="${in_name:-${cur_name:-Henrique Paixão}}"
  email="${in_email:-$cur_email}"
  {
    echo "# LabOS · identidade local do git (NÃO versionado)"
    echo "[user]"
    echo "	name = $name"
    echo "	email = $email"
  } > "$HOME/.gitconfig.local"
  ok "criado ~/.gitconfig.local ($name <$email>)"
fi

# ── Neovim: pré-aquecer plugins (LazyVim) ───────────────────────
step "Neovim / LazyVim"
if have nvim; then
  info "Sincronizando plugins (headless)…"
  nvim --headless "+Lazy! sync" +qa 2>/dev/null && ok "plugins do LazyVim prontos" \
    || warn "abra o nvim uma vez para concluir a instalação dos plugins"
else
  warn "nvim não encontrado — pulei o pré-aquecimento"
fi
