# AntaresOS · Evolução do Workspace — design (3 fases)

Data: 2026-07-19

Blueprint de melhorias no ambiente (Foodbot + CourtHub). Muita coisa da Fase 1
já existia — este doc registra o alvo completo e marca o que é delta.

## Fase 1 — Quick wins (config, baixo risco)
- ✅ **eza + bat** — aliases já existem (`aliases.zsh`).
- ✅ **navi + tldr** — instalados e wired (`NAVI_PATH` → `library/cheats`, widget zsh).
- ✅ **Starship** — já Matrix/nerd/cmd_duration/git ahead-behind/dart-node-python.
- ✅ **which-key + noice** — defaults do LazyVim.
- ⬜ **terminal-notifier** — instalar + hook zsh que notifica quando comando > N s termina (✓/✗). Novo módulo `stow/zsh/.zsh/notify.zsh`, var `NOTIFY_MIN` (default 30s).
- ⬜ **Starship** — adicionar módulos `kotlin`/`java` e `docker_context`.
- ⬜ **Nvim** — override de `lualine` no tema Matrix + habilitar `fzf-lua` (extra LazyVim).
- ⬜ **antares codex-open** — abre o vault Obsidian `~/Documents/Codex-Estudos` (Obsidian se instalado, senão nvim).

## Fase 2 — Estrutura do layout `work`
- **Tab `⟩HOME`** (1ª): fastfetch/onefetch + `git status` resumido dos 2 repos + TODOs.
- **Tab `⟩LAB`**: REPLs Kotlin (`kotlinc`), Dart, Clojure (`clj`) + buffer scratch (`~/.scratch`).
- **Statusbar (zjstatus) rica**: indicador de serviços/portas (8080 bff/core, Postgres 5432, Redis 6379, flutter) + path/hostname + CPU/RAM/bateria.
- Instalar: `onefetch`.

## Fase 3 — Ferramentas de projeto
- **lazydocker** (+ `antares docker`) — containers dos 2 projetos.
- **bruno CLI** (`bru run`) — coleções em `foodbot-service/bruno` e `CourtHub/bruno`. Instalar `@usebruno/cli` (npm).
- **Observability CourtHub** — pane com `/actuator/health` + logs OTLP/Prometheus.

## Fora de escopo
- IA no editor (CodeCompanion/Avante/Copilot) — dispensado por ora.
- git-delta, fd, ripgrep, zoxide, direnv, mise, btop — já no Brewfile.
