# Contexto global — AntaresOS ✦

Este é o ambiente pessoal do **Henrique Paixão**, gerido pelo repositório
[`AntaresOS`](https://github.com/HenriqueMachine/AntaresOS). Preferências que valem
para qualquer projeto:

## Ambiente
- **macOS** (Apple Silicon) · shell **zsh** + oh-my-zsh + **starship**.
- Terminal **Ghostty**, multiplexador **Zellij** (sessões persistentes).
- Editor **Neovim (LazyVim)**. Tema **Matrix** (verde fósforo sobre preto) em tudo.
- Dotfiles versionados em `~/Github/AntaresOS`, aplicados via **GNU Stow**.

## Stack de desenvolvimento
- Foco em **mobile / Flutter / Dart** (versões via **fvm**).
- CLIs modernas disponíveis: `eza`, `bat`, `fd`, `rg` (ripgrep), `fzf`,
  `zoxide`, `lazygit`, `git-delta`, `jq`.

## Convenções de trabalho
- **Commits sem `Co-Authored-By`.** Autor: Henrique Paixão.
- Ao mexer nos dotfiles, edite os arquivos em `~/Github/AntaresOS/stow/...` (a origem),
  nunca os symlinks no `$HOME` diretamente.
- Prefira soluções keyboard-driven e componíveis, alinhadas à filosofia do
  ambiente (menos context-switch mão↔mouse).
