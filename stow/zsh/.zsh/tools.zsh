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

# proj — sessionizer: fuzzy-pick de um projeto -> sessão Zellij nomeada
# (auto-detecta Flutter e usa o layout certo). Rode de um shell fora do Zellij.
proj() {
  local base="${PROJ_DIRS:-$HOME/Github}"
  local dir="$1"
  if [[ -z "$dir" ]]; then
    command -v fd >/dev/null 2>&1 || { print "fd não encontrado"; return 1; }
    dir=$(fd --type d --hidden --glob .git "$base" --max-depth 3 2>/dev/null \
          | sed 's#/\.git/\{0,1\}$##' \
          | fzf --prompt='projeto ❯ ' --delimiter=/ --with-nth=-2,-1) || return
  fi
  [[ -z "$dir" || ! -d "$dir" ]] && return
  local name="${${dir:t}//[^a-zA-Z0-9_-]/-}"
  local layout=dev
  [[ -f "$dir/pubspec.yaml" ]] && layout=flutter
  if [[ -n "$ZELLIJ" ]]; then
    print "já dentro do Zellij — saia (Ctrl-o d) e rode 'proj' de novo."
    return 1
  fi
  if zellij list-sessions -s 2>/dev/null | grep -qx "$name"; then
    (cd "$dir" && zellij attach "$name")
  else
    (cd "$dir" && zellij --layout "$layout" attach --create "$name")
  fi
}
