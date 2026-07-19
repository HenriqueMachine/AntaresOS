# AntaresOS · notify.zsh — avisa no desktop quando um comando longo termina
# Requer: terminal-notifier. Só notifica se o comando demorou >= NOTIFY_MIN segundos
# E se o terminal (Ghostty) não estiver em foco no momento do término.

: ${NOTIFY_MIN:=30}   # segundos mínimos p/ notificar

# comandos que nunca disparam (interativos/longos por natureza)
_notify_ignore=(nvim vim vi zellij ssh man less tig lazygit lazydocker htop btop top \
                mitmproxy mitmweb watch fzf claude codex tmux atuin)

command -v terminal-notifier >/dev/null 2>&1 || return

# marca início + guarda o comando
_notify_preexec() {
  _NOTIFY_CMD="$1"
  _NOTIFY_START=$SECONDS
}

# ao voltar ao prompt: calcula duração e notifica se passou do limite
_notify_precmd() {
  local exit=$?
  [[ -z "$_NOTIFY_START" ]] && return
  local dur=$(( SECONDS - _NOTIFY_START ))
  local cmd="$_NOTIFY_CMD"
  unset _NOTIFY_START _NOTIFY_CMD

  (( dur < NOTIFY_MIN )) && return

  # primeiro token do comando
  local name="${cmd%% *}"; name="${name:t}"
  [[ " ${_notify_ignore[*]} " == *" $name "* ]] && return

  # não notifica se o Ghostty já está em foco (você está olhando)
  local front
  front=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true' 2>/dev/null)
  [[ "$front" == "Ghostty" ]] && return

  local mmss=$(printf '%dm%02ds' $(( dur / 60 )) $(( dur % 60 )))
  if (( exit == 0 )); then
    terminal-notifier -title "✓ $name" -subtitle "concluído em $mmss" \
      -message "$cmd" -sound Glass -group antares-notify >/dev/null 2>&1
  else
    terminal-notifier -title "✗ $name (exit $exit)" -subtitle "falhou após $mmss" \
      -message "$cmd" -sound Basso -group antares-notify >/dev/null 2>&1
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _notify_preexec
add-zsh-hook precmd  _notify_precmd
