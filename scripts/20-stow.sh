#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  LabOS · 20 — cria os symlinks dos dotfiles com GNU Stow
# ═══════════════════════════════════════════════════════════════
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

step "Dotfiles (GNU Stow)"

if ! have stow; then
  err "GNU Stow não encontrado — rode o 10-brew-bundle.sh primeiro."
  exit 1
fi

# Cada subpasta de stow/ é um "pacote". --restow reaplica com segurança.
# --adopt NÃO é usado: preferimos falhar a sobrescrever um arquivo real.
PACKAGES=(zsh git starship ghostty zellij nvim claude)

# Faz backup de arquivos reais (não-symlink) que bloqueariam o stow.
backup_conflicts() {
  local pkg="$1"
  while IFS= read -r -d '' src; do
    local rel="${src#"$LABOS_DIR/stow/$pkg/"}"
    local target="$HOME/$rel"
    if [[ -e "$target" && ! -L "$target" ]]; then
      local bak="$target.labos-bak"
      warn "conflito: $rel já existe — movendo para ${bak##*/}"
      mv "$target" "$bak"
    fi
  done < <(find "$LABOS_DIR/stow/$pkg" -type f -print0)
}

for pkg in "${PACKAGES[@]}"; do
  if [[ -d "$LABOS_DIR/stow/$pkg" ]]; then
    backup_conflicts "$pkg"
    stow --dir="$LABOS_DIR/stow" --target="$HOME" --restow "$pkg"
    ok "linkado: $pkg"
  fi
done
