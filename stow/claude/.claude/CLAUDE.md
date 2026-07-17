# Contexto global — LabOS 🔬

Este é o ambiente pessoal do **Henrique Paixão**, gerido pelo repositório
[`LabOS`](https://github.com/HenriqueMachine/LabOS). Preferências que valem
para qualquer projeto:

## Ambiente
- **macOS** (Apple Silicon) · shell **zsh** + oh-my-zsh + **starship**.
- Terminal **Ghostty**, multiplexador **Zellij** (sessões persistentes).
- Editor **Neovim (LazyVim)**. Tema **Catppuccin Mocha** em tudo.
- Dotfiles versionados em `~/LabOS`, aplicados via **GNU Stow**.

## Stack de desenvolvimento
- Foco em **mobile / Flutter / Dart** (versões via **fvm**).
- CLIs modernas disponíveis: `eza`, `bat`, `fd`, `rg` (ripgrep), `fzf`,
  `zoxide`, `lazygit`, `git-delta`, `jq`.

## Convenções de trabalho
- **Commits sem `Co-Authored-By`.** Autor: Henrique Paixão.
- Ao mexer nos dotfiles, edite os arquivos em `~/LabOS/stow/...` (a origem),
  nunca os symlinks no `$HOME` diretamente.
- Prefira soluções keyboard-driven e componíveis, alinhadas à filosofia do
  ambiente (menos context-switch mão↔mouse).
