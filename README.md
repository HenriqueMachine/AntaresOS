<div align="center">

<img src="assets/logo.png" alt="AntaresOS" width="168" />

# AntaresOS

**A keyboard-driven, composable, persistent macOS workstation — provisioned with a single command.**

<sub>Named after Antares, the red supergiant at the heart of Scorpius — dressed in a Matrix green terminal.</sub>

<br/>

![macOS](https://img.shields.io/badge/macOS-Apple_Silicon-00ff41?style=flat-square&labelColor=000000)
![shell](https://img.shields.io/badge/shell-zsh-00ff41?style=flat-square&labelColor=000000)
![editor](https://img.shields.io/badge/editor-Neovim-00ff41?style=flat-square&labelColor=000000)
![theme](https://img.shields.io/badge/theme-Matrix-00ff41?style=flat-square&labelColor=000000)
![license](https://img.shields.io/badge/license-MIT-00ff41?style=flat-square&labelColor=000000)

</div>

---

## Overview

AntaresOS is my personal development environment, version-controlled so any Mac can
be rebuilt into it with **one clone and one command**. It is not a snapshot of
scattered dotfiles — it is a deliberately composed workstation, tuned for speed and
focus.

It is guided by three principles:

- **Keyboard-driven** — the hands stay on the home row. Navigation, editing, and
  window management are all a keystroke away, minimizing hand-to-mouse context
  switches.
- **Composable** — the terminal, multiplexer, editor, and AI agent are independent
  layers that snap together. Each can be understood, swapped, and tested on its own.
- **Persistent** — sessions survive closed windows and disconnects. You return
  exactly where you left off.

---

## The stack

Every layer is unified under a **Matrix** theme — phosphor green (`#00ff41`) on true
black.

| Layer | Tool | Role |
|---|---|---|
| **Terminal** | [Ghostty](https://ghostty.org) | GPU-accelerated, keyboard-first window |
| **Multiplexer** | [Zellij](https://zellij.dev) | panes and persistent sessions |
| **Shell** | zsh + [starship](https://starship.rs) | prompt, autosuggestions, syntax highlighting |
| **Editor** | [Neovim](https://neovim.io) + [LazyVim](https://lazyvim.org) | modal editing in the terminal |
| **Navigation** | `fzf` · `zoxide` · `eza` · `bat` · `lazygit` · `ripgrep` · `fd` | mouse-free movement |

---

## Quick start

```bash
git clone https://github.com/HenriqueMachine/AntaresOS.git ~/Github/AntaresOS
cd ~/Github/AntaresOS
./install.sh
```

`install.sh` is fully idempotent and runs, in order:

```
00 · install Homebrew (if missing)
10 · brew bundle      → every package in the Brewfile
20 · GNU Stow         → symlink the dotfiles into $HOME
30 · post-install     → oh-my-zsh, plugins, fvm,
                        git identity, and a LazyVim plugin warm-up
```

> **Dotfiles only, without installing packages:** `./install.sh --dotfiles`

---

## Daily use

Opening a terminal drops you into a clean shell. The environment is summoned on
demand:

`antares` is the environment's mini-CLI (`antares` with no argument prints help):

| Command | What it does |
|---|---|
| `antares open` (or `dev`) | opens the workspace — three Zellij tabs: **`edit`** (Neovim), **`term`** (two terminals), **`lib`** (the library) |
| `antares flutter` (or `fdev`) | opens the **Flutter** layout (editor + `flutter run` + devices) |
| `antares proj` (or `proj`) | fuzzy-pick a project under `~/Github` → open/attach its Zellij session (auto Flutter layout) |
| `v` / `nvim` | launches the editor (LazyVim) |
| `lg` | [lazygit](https://github.com/jesseduffield/lazygit) |
| `z <dir>` | smart directory jump ([zoxide](https://github.com/ajeetdsouza/zoxide)) · `Ctrl-R` history ([atuin](https://github.com/atuinsh/atuin)) |
| `run <file>` · `scratch <ext>` · `repl-py/clj/kt` | run code / open a scratch buffer / language REPLs |
| `top` · `sysinfo` | system monitor (btop) · machine info (fastfetch) |
| `antares update` | update the whole environment (`git pull` + brew + stow + plugins) |

<details>
<summary><b>Shell &amp; navigation shortcuts</b></summary>

| Key | Action |
|---|---|
| `Ctrl-R` | fuzzy history search (fzf) |
| `Ctrl-T` | fuzzy file search (fzf) |
| `Alt-C` | jump into a directory (fzf) |
| `ls` · `ll` · `la` · `lt` | listings via [eza](https://github.com/eza-community/eza) (icons, git) |
| `cat` | [bat](https://github.com/sharkdp/bat) with syntax highlighting |

</details>

<details>
<summary><b>Flutter / mobile</b></summary>

| Alias | Command |
|---|---|
| `fl` | `flutter` (routed through **fvm** when present) |
| `fpg` | `flutter pub get` |
| `frun` | `flutter run` |
| `fclean` | `flutter clean && flutter pub get` |
| `fbr` / `fbw` | `build_runner build` / `watch` |
| `fdoc` | `flutter doctor -v` |
| `fnew <name>` | scaffold a project and run `pub get` |

In Neovim, `<leader>F` opens the Flutter group (run, restart, devices, outline).

</details>

---

## Library &amp; Codex

A personal, version-controlled knowledge base kept in `library/` and synced with the
environment.

| Command | What it does |
|---|---|
| `<trigger>` (in Neovim) | expand a **Codex** snippet — type e.g. `stless` → a `StatelessWidget` |
| `snip` | fuzzy-search the Codex, preview the explanation + code, copy it |
| `codex-build` | regenerate the Codex snippets from the `.md` sources (runs on `antares update`) |
| `Ctrl-g` | open [navi](https://github.com/denisidoro/navi) — fuzzy-search a command and insert it |
| `note "text"` | append a timestamped line to `library/notes/inbox.md` |
| `lib` | open the library in Neovim |

**The Codex** (`library/codex/*.md`) is a dictionary of snippets — each entry is a
single source that both **expands in Neovim** (via LuaSnip) and reads as a **searchable
reference** with an explanation, tags and links:

```markdown
## StatelessWidget
- trigger: stless
- tags: flutter, widget

Widget with no state. Use it when the UI only depends on its inputs.

​```dart
class ${1:MyWidget} extends StatelessWidget { ... }
​```
```

Also: **commands** in `library/cheats/*.cheat` (navi) and free-form **snippets** in
`library/snippets/*.md`. The `lib` tab of `dev` opens it all ready to edit.

---

## Antares Proxy

An HTTP/HTTPS traffic inspector (the keyboard-driven, open-source Charles), built on
[mitmproxy](https://mitmproxy.org).

| Command | What it does |
|---|---|
| `antares proxy` | start the TUI (auto-saves the captured flows) |
| `antares proxy web` | browser UI (mitmweb) |
| `antares proxy mock` | start with the **mock/rewrite** addon (Charles' Map Local) |
| `antares proxy open [file]` | reopen/replay saved flows (fzf if omitted) |
| `antares proxy cert` | show the CA cert and how to trust it |
| `antares proxy android` / `ios` / `device` | set up the emulator / simulator / physical device |
| `antares proxy off` | remove the emulator proxy |
| `pxy` | open the dedicated Zellij layout |

**Mock/rewrite** rules live in `library/proxy/mocks.json` — match a URL (substring or
regex) and serve a local response without hitting the server. **Flutter** ignores the
system proxy/CA, so use the `flproxy` Codex snippet to route the debug build through it.

### How to use

**1. Start it**

```bash
antares proxy          # TUI on port 8080, auto-saving the session's flows
```

**2. Point a client at it and trust the certificate**

| Client | Command / steps |
|---|---|
| Android emulator | `antares proxy android` (sets the proxy + installs the cert) |
| iOS simulator | `antares proxy ios` (trusts the cert on the booted simulator) |
| Physical device | `antares proxy device` → set Wi-Fi proxy to the printed `IP:8080`, open `http://mitm.it`, install the cert |
| macOS apps | `antares proxy cert` prints the `security add-trusted-cert` command |

**3. Inspect the traffic** (in the mitmproxy TUI)

| Key | Action |
|---|---|
| `↑`/`↓` | move through the request list |
| `Enter` | open a flow (tabs: Request / Response / Detail) |
| `Tab` | switch between request and response |
| `f` | set a display **filter** (e.g. `~d api.myapp.com`, `~u /login`) |
| `r` | **replay** the selected request |
| `w` / `e` | save flows to a file / export a flow (e.g. as curl) |
| `q` | back / quit |

**4. Mock a response** (Charles' Map Local)

Edit `library/proxy/mocks.json`, set a rule's `"enabled": true`, then:

```bash
antares proxy mock     # matching requests are answered locally, server untouched
```

**5. Replay a past session**

```bash
antares proxy open     # fzf-pick a saved .flows file to reopen and inspect
```

**6. Debug a Flutter app**

Flutter ignores the system proxy/CA. In your `main()` (debug only), expand the
`flproxy` snippet in Neovim and call `enableDevProxy()` — for the Android emulator use
host `10.0.2.2`, for the iOS simulator `127.0.0.1`.

> When you're done: `antares proxy off` removes the emulator proxy.

---

## Repository layout

```
AntaresOS/
├── install.sh              # entry point (full, idempotent)
├── update.sh               # git pull + brew + restow + plugins
├── Brewfile                # the single source of truth for packages
├── scripts/
│   ├── lib.sh              # logging helpers
│   ├── 00-homebrew.sh
│   ├── 10-brew-bundle.sh
│   ├── 20-stow.sh          # symlinks (backs up conflicts)
│   └── 30-post.sh          # frameworks, agent, identity
├── stow/                   # each folder is one GNU Stow package
│   ├── zsh/                # .zshrc + .zsh/{exports,aliases,flutter,init,library}.zsh
│   ├── git/                # .gitconfig (+ delta) + .gitignore_global
│   ├── starship/           # Matrix prompt
│   ├── ghostty/            # terminal config + palette
│   ├── zellij/             # config + layouts (dev, flutter)
│   └── nvim/               # LazyVim + base16 Matrix + flutter-tools
├── library/                # cheats (navi) · snippets · notes
└── assets/                 # logo
```

Each package is an independent symlink — apply, remove, or reason about one without
touching the others. To change a dotfile, **edit the source in
`~/Github/AntaresOS/stow/...`**, never the symlink in `$HOME`.

---

## Identity &amp; secrets

Nothing sensitive is committed. On first run, `install.sh` writes your name and email
to **`~/.gitconfig.local`** (git-ignored); the tracked `.gitconfig` merely `include`s
it. Machine-specific overrides go in **`~/.zshrc.local`**.

---

## Extending

- **New package?** add it to the `Brewfile` and run `antares update`.
- **New config?** drop the file into `stow/<package>/` and run `./install.sh --dotfiles`.
- **New package group?** create `stow/<name>/` mirroring its path from `$HOME`, then
  add the name to the `PACKAGES` array in `scripts/20-stow.sh`.

---

<div align="center">
<sub>Crafted with focus and a keyboard by <b>Henrique Paixão</b> · MIT</sub>
</div>
