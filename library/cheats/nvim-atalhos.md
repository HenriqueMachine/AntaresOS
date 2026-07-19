# ⟩ NVIM — Atalhos (AntaresOS)

> LazyVim · leader = `Space` · smart-splits integrado ao Zellij

## Navegação de splits (nvim ⇄ Zellij)
| Tecla | Ação |
|-------|------|
| `Ctrl-h` | split à esquerda (cruza pro pane do Zellij na borda) |
| `Ctrl-j` | split abaixo |
| `Ctrl-k` | split acima |
| `Ctrl-l` | split à direita |

> Mesmo `Ctrl-hjkl` do Zellij: você anda entre panes e janelas do nvim sem trocar de tecla.

## Edição rápida (keymaps custom)
| Tecla | Ação |
|-------|------|
| `Ctrl-s` | salvar arquivo |
| `J` (visual) | mover seleção p/ baixo |
| `K` (visual) | mover seleção p/ cima |
| `Ctrl-d` / `Ctrl-u` | meia-página ↓/↑ (centraliza) |
| `n` / `N` | próxima/anterior busca (centraliza) |

## Arquivos & busca (LazyVim)
| Tecla | Ação |
|-------|------|
| `<leader>ff` | buscar arquivos (Telescope) |
| `<leader>fg` | grep no projeto (live grep) |
| `<leader>fe` / `<leader>e` | explorer (neo-tree) |
| `<leader>fb` | buffers abertos |
| `<leader>fr` | arquivos recentes |
| `<leader><leader>` | arquivos (atalho rápido) |

## Código / LSP (LazyVim)
| Tecla | Ação |
|-------|------|
| `gd` | ir para definição |
| `gr` | referências |
| `K` (normal) | hover / doc |
| `<leader>ca` | code action |
| `<leader>cr` | renomear símbolo |
| `<leader>cd` | diagnóstico da linha |
| `]d` / `[d` | próximo/anterior diagnóstico |
| `<leader>cf` | formatar |

## Flutter / Dart (flutter-tools)
| Tecla | Ação |
|-------|------|
| `<leader>Fr` | Flutter Run |
| `<leader>FR` | Flutter Restart (hot restart) |
| `<leader>Fq` | Flutter Quit |
| `<leader>Fd` | Flutter Devices |
| `<leader>Fe` | Flutter Emulators |
| `<leader>Fo` | Flutter Outline (toggle) |

## Rodar código inline (sniprun)
| Tecla | Ação |
|-------|------|
| `<leader>r` (n/v) | rodar bloco/linha selecionada |
| `<leader>rc` | reset do sniprun |
| `<leader>rq` | fechar saída |

## Snippets Codex (LuaSnip)
Snippets da library carregam de `$ANTARES_LIB/codex/.build` (VSCode format).
Digite o prefixo do snippet e expanda com `Tab`.

## Git (LazyVim · gitsigns)
| Tecla | Ação |
|-------|------|
| `<leader>gg` | LazyGit |
| `]h` / `[h` | próximo/anterior hunk |
| `<leader>ghs` | stage hunk |
| `<leader>ghr` | reset hunk |

---
_Editar este cheat: `nvim ~/Github/AntaresOS/library/cheats/nvim-atalhos.md`_
