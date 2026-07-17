# ═══════════════════════════════════════════════════════════════
#  LabOS · .zshrc — ponto de entrada do shell
#  A config real vive em ~/.zsh/*.zsh (modular e versionada).
# ═══════════════════════════════════════════════════════════════

# ── Auto-attach ao Zellij ───────────────────────────────────────
# Abriu o terminal → cai numa sessão persistente (reaproveita ou cria).
# Pula quando dentro do nvim, VSCode, ou já dentro do Zellij.
if [[ -z "$ZELLIJ" && -z "$INSIDE_NVIM" && "$TERM_PROGRAM" != "vscode" ]]; then
  if command -v zellij >/dev/null 2>&1; then
    export ZELLIJ_AUTO_ATTACH=true
    export ZELLIJ_AUTO_EXIT=true
    eval "$(zellij setup --generate-auto-start zsh 2>/dev/null)"
  fi
fi

# ── Oh My Zsh ───────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""                       # prompt é o starship (ver init.zsh)
plugins=(git flutter fzf)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# ── Módulos do LabOS ────────────────────────────────────────────
# Ordem importa: exports → aliases → flutter → init (prompt/tools).
for _mod in exports aliases flutter init; do
  [[ -f "$HOME/.zsh/$_mod.zsh" ]] && source "$HOME/.zsh/$_mod.zsh"
done
unset _mod

# ── Overrides locais (não versionado) ───────────────────────────
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
