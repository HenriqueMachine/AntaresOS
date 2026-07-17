# ═══════════════════════════════════════════════════════════════
#  LabOS · init.zsh — prompt, ferramentas interativas e plugins
#  Carregado por último para envolver tudo que já foi definido.
# ═══════════════════════════════════════════════════════════════

# ── starship (prompt) ───────────────────────────────────────────
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# ── zoxide (cd inteligente → z) ─────────────────────────────────
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# ── fzf (Ctrl-R histórico · Ctrl-T arquivos · Alt-C dirs) ───────
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh) 2>/dev/null
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  # tema Catppuccin Mocha para o fzf
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a --height 40% --layout=reverse --border"
fi

# ── Plugins do zsh (via Homebrew) ───────────────────────────────
_brew_prefix="$(brew --prefix 2>/dev/null)"
if [[ -n "$_brew_prefix" ]]; then
  source "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
  # syntax-highlighting DEVE ser a última coisa carregada
  source "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
fi
unset _brew_prefix
