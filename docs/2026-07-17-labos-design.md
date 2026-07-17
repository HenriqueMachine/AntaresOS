# LabOS — documento de design

**Data:** 2026-07-17 · **Autor:** Henrique Paixão

## Objetivo

Um ambiente de desenvolvimento macOS pessoal, versionado no GitHub, que se
reconstrói numa máquina nova com **um clone + um comando**. Otimizado para
produtividade real, não apenas replicado.

## Filosofia

1. **Keyboard-driven, mouse-free** — menos context-switch mão↔mouse.
2. **Componível** — terminal + multiplexador + editor + agente que se
   encaixam como camadas independentes.
3. **Persistente e remoto** — sessões sobrevivem a desconexões (camada remota
   fica para uma fase 2).

## Decisões (brainstorming)

| Tema | Decisão |
|------|---------|
| Escopo | Bootstrap completo (Homebrew + apps + dotfiles) |
| SO-alvo | Só macOS (Apple Silicon) |
| Gerenciador de dotfiles | GNU Stow |
| Identidade/segredos | `~/.gitconfig.local` não-versionado, criado no install |
| Nível de otimização | "De verdade" (starship, plugins, aliases, fzf) |
| Terminal | Ghostty (migra do iTerm2) |
| Multiplexador | Zellij, com auto-attach |
| Editor | Neovim / LazyVim |
| Agente | Claude Code no fluxo |
| Tema | Catppuccin Mocha em todas as camadas |
| Kit mobile | Flutter completo (fvm, aliases, layout, flutter-tools) |
| Instalação | Clonar e rodar `./install.sh` |
| Nome/visibilidade | `LabOS`, público |
| Commits | Sem `Co-Authored-By`, autor Henrique Paixão |

## Arquitetura

```
LabOS/
├── install.sh / update.sh      # orquestradores idempotentes
├── Brewfile                    # fonte da verdade dos programas
├── scripts/                    # 00-homebrew · 10-brew-bundle · 20-stow · 30-post
└── stow/                       # 1 pasta = 1 pacote stowável
    ├── zsh/ git/ starship/ ghostty/ zellij/ nvim/ claude/
```

### Fluxo do install
`Homebrew → brew bundle → stow (symlinks) → oh-my-zsh + plugins + fvm +
Claude Code + identidade git + pré-aquecer LazyVim`. Cada passo é idempotente.

### Isolamento das unidades
- **scripts/lib.sh** — helpers de log/cor, sem efeito colateral.
- Cada `NN-*.sh` — uma responsabilidade, executável isoladamente.
- Cada pacote em `stow/` — uma ferramenta, linkável isoladamente.
- Config do zsh é modular (`~/.zsh/{exports,aliases,flutter,init}.zsh`).

## Segurança / segredos
Nada sensível no repositório. Identidade do git vive em `~/.gitconfig.local`
(fora do versionamento). Overrides de máquina em `~/.zshrc.local`.

## Fora de escopo (fase 2)
Camada remota (Tailscale + mosh), ajustes de `defaults` do macOS.
