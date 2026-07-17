#!/usr/bin/env bash
# AntaresOS · 20 — symlinks (GNU Stow)
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Dotfiles (GNU Stow)"

if ! have stow; then
  err "GNU Stow não encontrado — rode o 10-brew-bundle.sh primeiro."
  exit 1
fi

PACKAGES=(zsh git starship ghostty zellij nvim)

# --no-folding: linka arquivo a arquivo em vez de dobrar a pasta inteira num
# symlink. Assim ~/.config/nvim etc. ficam como diretórios reais, e apps podem
# escrever arquivos de runtime (lazy-lock.json…) sem poluir o repo.
STOW_FLAGS=(--dir="$ANTARES_DIR/stow" --target="$HOME" --no-folding)

# Só faz backup de um arquivo real (não-symlink) que NÃO seja já nosso
# (evita mover os próprios fontes vistos através de um symlink de pasta).
backup_conflicts() {
  local pkg="$1"
  while IFS= read -r -d '' src; do
    local rel="${src#"$ANTARES_DIR/stow/$pkg/"}"
    local target="$HOME/$rel"
    [[ -e "$target" ]] || continue
    [[ -L "$target" ]] && continue
    local real; real="$(realpath "$target" 2>/dev/null || true)"
    case "$real" in "$ANTARES_DIR"/*) continue ;; esac
    local bak="$target.antares-bak"
    warn "conflito: $rel já existe — movendo para ${bak##*/}"
    mv "$target" "$bak"
  done < <(find "$ANTARES_DIR/stow/$pkg" -type f -print0)
}

for pkg in "${PACKAGES[@]}"; do
  if [[ -d "$ANTARES_DIR/stow/$pkg" ]]; then
    backup_conflicts "$pkg"
    stow "${STOW_FLAGS[@]}" --restow "$pkg"
    ok "linkado: $pkg"
  fi
done
