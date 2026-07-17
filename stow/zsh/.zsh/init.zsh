# AntaresOS · init.zsh

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh) 2>/dev/null
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#0b140b,bg:#000000,spinner:#48ffe0,hl:#35c9ff \
    --color=fg:#00ff41,header:#35c9ff,info:#f5d76e,pointer:#00ff41 \
    --color=marker:#48ffe0,fg+:#7cffa0,prompt:#00ff41,hl+:#48ffe0 \
    --color=border:#14371f,selected-bg:#14371f --height 40% --layout=reverse --border"
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#2e6b3e"

_brew_prefix="$(brew --prefix 2>/dev/null)"
if [[ -n "$_brew_prefix" ]]; then
  source "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
  # syntax-highlighting deve ser o último
  source "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
fi
unset _brew_prefix
