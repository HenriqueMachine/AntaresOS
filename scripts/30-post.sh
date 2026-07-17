#!/usr/bin/env bash
# AntaresOS · 30 — pós-instalação
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Oh My Zsh"
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  ok "Oh My Zsh já presente"
else
  info "Instalando Oh My Zsh…"
  RUNZSH=no KEEP_ZSHRC=yes CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ok "Oh My Zsh instalado"
fi

step "Shell padrão"
if [[ "$SHELL" != *zsh ]]; then
  warn "Shell atual não é zsh. Para trocar: chsh -s $(command -v zsh)"
else
  ok "zsh já é o shell padrão"
fi

step "fvm (Flutter)"
if have fvm; then
  ok "fvm já instalado ($(fvm --version 2>/dev/null))"
elif have dart; then
  info "Instalando fvm via dart pub global…"
  dart pub global activate fvm || warn "não consegui instalar o fvm agora"
else
  warn "dart/flutter ainda não disponível — instale o fvm depois: dart pub global activate fvm"
fi

step "Tema (bat/delta)"
info "bat e delta usam o tema 'base16' (herdam os ANSI verdes do terminal)"
have bat && ok "nada a baixar — tema base16 é embutido"

step "Identidade do git (~/.gitconfig.local)"
if [[ -f "$HOME/.gitconfig.local" ]]; then
  ok "~/.gitconfig.local já existe — mantendo"
else
  cur_name="$(git config --global user.name 2>/dev/null || true)"
  cur_email="$(git config --global user.email 2>/dev/null || true)"
  # Após o stow, ~/.gitconfig já é o do AntaresOS (sem identidade). Busca no backup.
  if [[ -z "$cur_email" && -f "$HOME/.gitconfig.antares-bak" ]]; then
    cur_name="$(git config -f "$HOME/.gitconfig.antares-bak" user.name 2>/dev/null || echo "$cur_name")"
    cur_email="$(git config -f "$HOME/.gitconfig.antares-bak" user.email 2>/dev/null || true)"
  fi
  if [[ -t 0 ]]; then
    printf '  Nome para os commits [%s]: ' "${cur_name:-Henrique Paixão}"
    read -r in_name
    printf '  Email para os commits [%s]: ' "${cur_email:-}"
    read -r in_email
  fi
  name="${in_name:-${cur_name:-Henrique Paixão}}"
  email="${in_email:-$cur_email}"
  {
    echo "[user]"
    echo "	name = $name"
    echo "	email = $email"
  } > "$HOME/.gitconfig.local"
  ok "criado ~/.gitconfig.local ($name <$email>)"
fi

step "Codex"
bash "$ANTARES_DIR/scripts/codex-build.sh" || warn "não consegui gerar o Codex"

step "Neovim / LazyVim"
if have nvim; then
  info "Sincronizando plugins (headless)…"
  nvim --headless "+Lazy! sync" +qa 2>/dev/null && ok "plugins do LazyVim prontos" \
    || warn "abra o nvim uma vez para concluir a instalação dos plugins"
else
  warn "nvim não encontrado — pulei o pré-aquecimento"
fi
