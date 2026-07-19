# AntaresOS · Layout `work` — Foodbot + CourtHub em paralelo

Data: 2026-07-19

## Objetivo
Um layout Zellij único para trabalhar nos dois projetos ao mesmo tempo: agentes
Claude por projeto, stacks de run por projeto, e um editor com cheatsheet de
atalhos do Neovim. Abre com `zellij -l work`.

## Sessão: 5 tabs (barra Matrix / zjstatus)

Todas as tabs herdam o `default_tab_template` com zjstatus (mesmo visual do
`dev.kdl`/`flutter.kdl`).

| # | Tab | cwd | Panes |
|---|-----|-----|-------|
| 1 | `FOODBOT⟩AGENTS`  | `~/Foodbot`         | `claude` \| `claude` (vertical) — **auto-launch** |
| 2 | `FOODBOT⟩STACK`   | `~/Foodbot`         | `front` \| (`back` / `term`) — **hint** |
| 3 | `COURTHUB⟩AGENTS` | `~/Github/CourtHub` | `claude` \| `claude` (vertical) — **auto-launch** |
| 4 | `COURTHUB⟩STACK`  | `~/Github/CourtHub` | `infra` \| (`bff` / `core`) — **hint** |
| 5 | `⟩NVIM`           | `~/`                | `nvim` \| `nvim-atalhos.md` (cheatsheet) |

Tab 1 tem `focus=true`.

### Comportamento dos panes
- **AGENTS**: os 2 panes executam `claude` direto (auto-launch), lado a lado.
- **STACK**: panes abrem no zsh com um hint impresso (`▶ <comando>`) e o usuário
  aperta Enter — **não** sobem docker/flutter sozinhos ao abrir a sessão.
  Padrão idêntico ao `flutter.kdl` existente.

### Comandos (hints) das tabs STACK
FOODBOT⟩STACK (cwd `~/Foodbot`):
- `front` → `make frontend`   (foodbot-app · flutter dev)
- `back`  → `make backend`    (foodbot-service · docker compose)
- `term`  → zsh livre

COURTHUB⟩STACK (cwd `~/Github/CourtHub`):
- `infra` → `make courthub-service`  (Postgres + Redis)
- `bff`   → `./gradlew :bff:bootRun --args='--spring.profiles.active=local'`
- `core`  → `./gradlew :core:bootRun --args='--spring.profiles.active=local'`

### Layout STACK (2 verticais + 1 horizontal)
```
┌──────────┬─────────────┐
│ esquerda │  topo-dir   │
│          ├─────────────┤
│          │  baixo-dir  │
└──────────┴─────────────┘
```

## Arquivos
1. `stow/zellij/.config/zellij/layouts/work.kdl` — novo layout.
2. `library/cheats/nvim-atalhos.md` — cheatsheet dos atalhos reais do setup:
   - LazyVim (leader = Space) — `<leader>ff`, `<leader>fe`, etc.
   - smart-splits: `Ctrl-h/j/k/l` (navega splits do nvim e cruza pro Zellij).
   - keymaps custom: `Ctrl-s` salvar, `J/K` mover seleção, `Ctrl-d/u` centraliza.
   - flutter-tools: `<leader>Fr/Fq/FR/Fd/Fe/Fo`.
   - sniprun: `<leader>r` rodar, `<leader>rc` reset, `<leader>rq` fechar.
   - codex/LuaSnip: snippets da library.

## Como abrir
`zellij -l work` (ou attach numa sessão nova). Opcional futuro: subcomando
`antares work` no mini-CLI.

## Fora de escopo
- Não altera `dev.kdl`/`flutter.kdl`/`proxy.kdl` existentes.
- Não padroniza o template do zjstatus nos layouts antigos (fica pra outra vez).
