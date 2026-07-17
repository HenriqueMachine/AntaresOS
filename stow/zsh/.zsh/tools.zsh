# AntaresOS · tools.zsh — DevX (atuin, direnv, mise, monitor)

# atuin — histórico turbinado (Ctrl-R). Carregado após o fzf para vencer o bind.
# --disable-up-arrow mantém a seta ↑ com o comportamento normal do zsh.
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# direnv — carrega .envrc por diretório
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# mise — versões por projeto (complementa o fvm do Flutter)
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# monitor / info
command -v btop      >/dev/null 2>&1 && alias top='btop'
command -v fastfetch >/dev/null 2>&1 && alias sysinfo='fastfetch'
