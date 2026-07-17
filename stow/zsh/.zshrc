# AntaresOS · .zshrc

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git flutter fzf)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

for _mod in exports aliases flutter init; do
  [[ -f "$HOME/.zsh/$_mod.zsh" ]] && source "$HOME/.zsh/$_mod.zsh"
done
unset _mod

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
