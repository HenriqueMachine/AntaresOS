# ═══════════════════════════════════════════════════════════════
#  LabOS · aliases.zsh — atalhos do dia a dia
# ═══════════════════════════════════════════════════════════════

# ── Listagem (eza no lugar do ls) ───────────────────────────────
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons'
  alias l='eza -lbF --git --icons --group-directories-first'
  alias ll='eza -lbGF --git --icons --group-directories-first'
  alias la='eza -lbhHigUmuSa --git --icons --group-directories-first'
  alias lt='eza --tree --level=2 --icons'
  alias ltt='eza --tree --level=3 --icons'
fi

# ── Arquivos / conteúdo ─────────────────────────────────────────
command -v bat >/dev/null 2>&1 && alias cat='bat --paging=never'
command -v rg  >/dev/null 2>&1 && alias grep='rg'

# ── Editor ──────────────────────────────────────────────────────
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ── Git (complementa o plugin git do oh-my-zsh) ─────────────────
alias lg='lazygit'
alias gs='git status -sb'
alias gl="git log --oneline --graph --decorate --all"
alias gd='git diff'
alias gco='git checkout'
alias gcm='git commit -m'
alias gaa='git add --all'
alias gp='git push'
alias gpl='git pull'

# ── Zellij (multiplexador) ──────────────────────────────────────
alias zj='zellij'
alias dev='zellij --layout dev attach --create labos'   # sobe o layout principal
alias fdev='zellij --layout flutter attach --create flutter'  # layout mobile

# ── Navegação ───────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias reload='exec zsh'

# ── LabOS (autogestão do ambiente) ──────────────────────────────
export LABOS_DIR="${LABOS_DIR:-$HOME/LabOS}"
alias labos="cd $LABOS_DIR"
alias labos-update="(cd $LABOS_DIR && ./update.sh)"
alias labos-edit="nvim $LABOS_DIR"
