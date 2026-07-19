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
_zj_open() {
  local session="$1" layout="$2"
  if zellij list-sessions -s 2>/dev/null | grep -qx "$session"; then
    zellij attach "$session"
  else
    zellij --layout "$layout" attach --create "$session"
  fi
}
dev()  { _zj_open antares dev; }
fdev() { _zj_open flutter flutter; }
work() { _zj_open work work; }

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias reload='exec zsh'

export ANTARES_DIR="${ANTARES_DIR:-$HOME/Github/AntaresOS}"

# entra na coleção Bruno do projeto (rode `bru run <req.bru>` depois)
_antares_bruno() {
  local dir
  case "$1" in
    fb|foodbot)  dir="$HOME/Foodbot/foodbot-service/bruno" ;;
    ch|courthub) dir="$HOME/Github/CourtHub/bruno" ;;
    *) print "uso: antares bruno <fb|ch>"; return 1 ;;
  esac
  [[ -d "$dir" ]] || { print "coleção não encontrada: $dir"; return 1; }
  cd "$dir" && { print "em $dir — rode:  bru run <req.bru>  (ou: bru run . --env local)"; ls; }
}

# antares — mini-CLI do ambiente
antares() {
  case "$1" in
    open|dev)     dev ;;
    work)         work ;;
    flutter|fl)   fdev ;;
    proj)         proj ;;
    proxy)        _antares_proxy "${@:2}" ;;
    update|up)    ( cd "$ANTARES_DIR" && ./update.sh ) ;;
    edit)         nvim "$ANTARES_DIR" ;;
    codex)        codex-build ;;
    codex-open|estudos)  estudos ;;
    docker)       lazydocker ;;
    health|observe)  "$ANTARES_DIR/scripts/courthub-observe.sh" ;;
    bruno|api)    _antares_bruno "${@:2}" ;;
    cd)           cd "$ANTARES_DIR" ;;
    ""|help|-h|--help)
      print "antares — ambiente AntaresOS"
      print "  open      abre o ambiente (editor + terminais + lib)"
      print "  work      Foodbot + CourtHub em paralelo (5 tabs)"
      print "  flutter   layout Flutter"
      print "  proj      sessionizer de projetos"
      print "  proxy     inspeção de tráfego (mitmproxy) — 'antares proxy help'"
      print "  update    atualiza tudo (git + brew + stow + plugins)"
      print "  edit      edita os dotfiles no Neovim"
      print "  codex     regenera os snippets do Codex"
      print "  estudos   abre o vault Codex de Estudos (Obsidian)"
      print "  docker    lazydocker (containers dos projetos)"
      print "  health    watch de health do CourtHub (Actuator)"
      print "  bruno     entra na coleção Bruno (antares bruno <fb|ch>)"
      print "  cd        vai para o repositório"
      ;;
    *) print "antares: subcomando '$1' desconhecido — veja 'antares help'"; return 1 ;;
  esac
}
