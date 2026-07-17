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

| Command | What it does |
|---|---|
| `dev` | opens the **editor + two terminals** layout (Zellij session `antares`) |
| `fdev` | opens the **Flutter** layout (editor + `flutter run` + devices) |
| `v` / `nvim` | launches the editor (LazyVim) |
| `lg` | [lazygit](https://github.com/jesseduffield/lazygit) |
| `z <dir>` | smart directory jump ([zoxide](https://github.com/ajeetdsouza/zoxide)) |
| `antares-update` | update the whole environment (`git pull` + brew + stow + plugins) |

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
│   ├── zsh/                # .zshrc + .zsh/{exports,aliases,flutter,init}.zsh
│   ├── git/                # .gitconfig (+ delta) + .gitignore_global
│   ├── starship/           # Matrix prompt
│   ├── ghostty/            # terminal config + palette
│   ├── zellij/             # config + layouts (dev, flutter)
│   └── nvim/               # LazyVim + base16 Matrix + flutter-tools
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

- **New package?** add it to the `Brewfile` and run `antares-update`.
- **New config?** drop the file into `stow/<package>/` and run `./install.sh --dotfiles`.
- **New package group?** create `stow/<name>/` mirroring its path from `$HOME`, then
  add the name to the `PACKAGES` array in `scripts/20-stow.sh`.

---

<div align="center">
<sub>Crafted with focus and a keyboard by <b>Henrique Paixão</b> · MIT</sub>
</div>
