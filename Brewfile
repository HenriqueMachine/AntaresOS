# ═══════════════════════════════════════════════════════════════
#  LabOS · Brewfile — a fonte da verdade dos programas
#  Instale com:  brew bundle --file=Brewfile
# ═══════════════════════════════════════════════════════════════

# ── Taps ────────────────────────────────────────────────────────
# (nenhum tap extra necessário no momento)

# ── Núcleo do ambiente (as camadas) ─────────────────────────────
brew "stow"                # gerenciador de symlinks dos dotfiles
brew "starship"            # prompt do shell (Catppuccin)
brew "zellij"              # multiplexador / sessões persistentes
brew "neovim"              # editor (LazyVim)
brew "zsh-autosuggestions" # sugestões inline no zsh
brew "zsh-syntax-highlighting"

# ── Navegação keyboard-driven ───────────────────────────────────
brew "fzf"                 # fuzzy finder (Ctrl-R / Ctrl-T)
brew "zoxide"              # cd inteligente (z)
brew "eza"                 # ls moderno
brew "bat"                 # cat com syntax highlight
brew "ripgrep"             # busca em conteúdo (rg) — usado pelo nvim/fzf
brew "fd"                  # find moderno — usado pelo nvim/fzf
brew "git-delta"           # diffs bonitos no git
brew "lazygit"             # UI de git no terminal
brew "jq"                  # manipulação de JSON
brew "tldr"                # exemplos rápidos de comandos

# ── Ferramentas que você já usava ───────────────────────────────
brew "awscli"
brew "bash"
brew "gh"
brew "gradle"
brew "newsboat"
brew "poppler"
brew "python@3.11"
brew "trivy"

# ── Mobile / Flutter ────────────────────────────────────────────
# fvm gerencia versões do Flutter; o SDK do Flutter também via cask abaixo
cask "flutter"

# ── Apps (casks) ────────────────────────────────────────────────
cask "ghostty"                    # terminal keyboard-driven
cask "font-fira-code-nerd-font"   # fonte com ícones (Nerd Font)
cask "010-editor"
cask "ngrok"

# ── Agente de IA ────────────────────────────────────────────────
# Claude Code é instalado via script (npm/curl) no post-install,
# pois não vive no Homebrew — veja scripts/30-post.sh
