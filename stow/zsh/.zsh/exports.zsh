# ═══════════════════════════════════════════════════════════════
#  LabOS · exports.zsh — PATH e variáveis de ambiente
# ═══════════════════════════════════════════════════════════════

# Homebrew (Apple Silicon)
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Binários locais do usuário
export PATH="$HOME/.local/bin:$PATH"

# Editor padrão
export EDITOR="nvim"
export VISUAL="nvim"

# bat como pager de cores (usado por várias ferramentas)
export PAGER="less"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ── Android SDK ─────────────────────────────────────────────────
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"

# ── Dart / Flutter (fvm + pub global) ───────────────────────────
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$HOME/fvm/default/bin:$PATH"

# ── NVM (Node) ──────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"

# ── Histórico generoso e compartilhado ──────────────────────────
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS INC_APPEND_HISTORY
