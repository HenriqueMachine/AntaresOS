#!/usr/bin/env bash
# AntaresOS · 20 — symlinks (GNU Stow)
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Dotfiles (GNU Stow)"

if ! have stow; then
  err "GNU Stow não encontrado — rode o 10-brew-bundle.sh primeiro."
  exit 1
fi

PACKAGES=(zsh git starship ghostty zellij nvim)

backup_conflicts() {
  local pkg="$1"
  while IFS= read -r -d '' src; do
    local rel="${src#"$ANTARES_DIR/stow/$pkg/"}"
    local target="$HOME/$rel"
    if [[ -e "$target" && ! -L "$target" ]]; then
      local bak="$target.antares-bak"
      warn "conflito: $rel já existe — movendo para ${bak##*/}"
      mv "$target" "$bak"
    fi
  done < <(find "$ANTARES_DIR/stow/$pkg" -type f -print0)
}

for pkg in "${PACKAGES[@]}"; do
  if [[ -d "$ANTARES_DIR/stow/$pkg" ]]; then
    backup_conflicts "$pkg"
    stow --dir="$ANTARES_DIR/stow" --target="$HOME" --restow "$pkg"
    ok "linkado: $pkg"
  fi
done
