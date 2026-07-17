# AntaresOS · aliases.zsh

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons'
  alias l='eza -lbF --git --icons --group-directories-first'
  alias ll='eza -lbGF --git --icons --group-directories-first'
  alias la='eza -lbhHigUmuSa --git --icons --group-directories-first'
  alias lt='eza --tree --level=2 --icons'
  alias ltt='eza --tree --level=3 --icons'
fi

command -v bat >/dev/null 2>&1 && alias cat='bat --paging=never'
command -v rg  >/dev/null 2>&1 && alias grep='rg'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'

alias lg='lazygit'
alias gs='git status -sb'
alias gl="git log --oneline --graph --decorate --all"
alias gd='git diff'
alias gco='git checkout'
alias gcm='git commit -m'
alias gaa='git add --all'
alias gp='git push'
alias gpl='git pull'

alias zj='zellij'
dev()  { zellij attach antares   2>/dev/null || zellij --session antares   --layout dev; }
fdev() { zellij attach flutter 2>/dev/null || zellij --session flutter --layout flutter; }

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias reload='exec zsh'

export ANTARES_DIR="${ANTARES_DIR:-$HOME/Github/AntaresOS}"
alias antares="cd $ANTARES_DIR"
alias antares-update="(cd $ANTARES_DIR && ./update.sh)"
alias antares-edit="nvim $ANTARES_DIR"
