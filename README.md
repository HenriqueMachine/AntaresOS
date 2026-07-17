<div align="center">

# 🔬 LabOS

**Meu laboratório operacional** — uma estação de trabalho macOS
_keyboard-driven_, componível e persistente, que se reconstrói do zero
com **um clone e um comando**.

<samp>

`keyboard-driven` · `componível` · `persistente`

</samp>

![macOS](https://img.shields.io/badge/macOS-Apple_Silicon-000?logo=apple&logoColor=white)
![shell](https://img.shields.io/badge/shell-zsh-89b4fa)
![theme](https://img.shields.io/badge/theme-Catppuccin_Mocha-cba6f7)
![license](https://img.shields.io/badge/license-MIT-a6e3a1)

</div>

---

## ✦ Filosofia

O LabOS é montado em torno de três princípios:

1. **Keyboard-driven, mouse-free** — menos context-switch mão↔mouse; foco e
   velocidade. Navegação, edição e janelas vivem sob os dedos.
2. **Componível** — terminal, multiplexador, editor e agente de IA são
   camadas independentes que se encaixam. Cada peça pode ser entendida,
   trocada e testada isoladamente.
3. **Persistente** — as sessões sobrevivem a fechamentos e desconexões. Você
   volta exatamente de onde parou. _(A camada remota — Tailscale + mosh — está
   planejada para uma fase 2.)_

---

## ✦ As camadas

| Camada | Ferramenta | Papel |
|---|---|---|
| 🪟 **Terminal** | [Ghostty](https://ghostty.org) | a janela — rápida, GPU, keyboard-first |
| 🧩 **Multiplexador** | [Zellij](https://zellij.dev) | painéis + sessões persistentes (auto-attach) |
| 🐚 **Shell** | zsh + [starship](https://starship.rs) | prompt + autosuggestions + syntax-highlight |
| ✍️ **Editor** | [Neovim](https://neovim.io) / [LazyVim](https://lazyvim.org) | edição modal no terminal |
| 🤖 **Agente** | [Claude Code](https://claude.com/claude-code) | IA no fluxo, num painel próprio |
| 🧭 **Navegação** | `fzf` · `zoxide` · `eza` · `bat` · `lazygit` · `ripgrep` · `fd` | movimento sem mouse |

Tudo unificado no tema **Catppuccin Mocha** 🌿.

---

## ✦ Instalação (máquina nova)

```bash
git clone https://github.com/HenriqueMachine/LabOS.git ~/LabOS
cd ~/LabOS
./install.sh
```

Isso, em ordem e de forma **idempotente**:

```
00 · instala o Homebrew (se faltar)
10 · brew bundle  → todos os programas do Brewfile
20 · GNU Stow     → cria os symlinks dos dotfiles no seu $HOME
30 · pós-install  → oh-my-zsh, plugins, fvm, Claude Code,
                    identidade do git e pré-aquecimento do LazyVim
```

Ao final: abra o **Ghostty**, o Zellij sobe sozinho, e você já está no ambiente.

> **Só os dotfiles, sem instalar programas?**
> `./install.sh --dotfiles`

---

## ✦ Uso no dia a dia

| Comando | O que faz |
|---|---|
| _(abrir o terminal)_ | cai numa sessão **Zellij** persistente automaticamente |
| `dev` | layout **editor + terminal + Claude Code** |
| `fdev` | layout **Flutter** (editor + `flutter run` + devices) |
| `v` / `nvim` | abre o editor (LazyVim) |
| `lg` | [lazygit](https://github.com/jesseduffield/lazygit) |
| `z <pasta>` | pulo inteligente de diretório ([zoxide](https://github.com/ajeetdsouza/zoxide)) |
| `labos-update` | atualiza todo o ambiente (`git pull` + brew + stow + plugins) |

### Atalhos-chave

<details>
<summary><b>Shell / navegação</b></summary>

| Tecla | Ação |
|---|---|
| `Ctrl-R` | busca fuzzy no histórico (fzf) |
| `Ctrl-T` | busca fuzzy de arquivos (fzf) |
| `Alt-C` | pula para um diretório (fzf) |
| `ls` / `ll` / `la` / `lt` | listagens com [eza](https://github.com/eza-community/eza) (ícones, git) |
| `cat` | [bat](https://github.com/sharkdp/bat) com syntax highlight |

</details>

<details>
<summary><b>Flutter / mobile</b></summary>

| Alias | Comando |
|---|---|
| `fl` | `flutter` (roteado pelo **fvm** quando presente) |
| `fpg` | `flutter pub get` |
| `frun` | `flutter run` |
| `fclean` | `flutter clean && flutter pub get` |
| `fbr` / `fbw` | `build_runner build` / `watch` |
| `fdoc` | `flutter doctor -v` |
| `fnew <nome>` | cria um projeto e já roda `pub get` |

No Neovim: `<leader>F` abre o grupo Flutter (run, restart, devices, outline…).

</details>

---

## ✦ Estrutura do repositório

```
LabOS/
├── install.sh              # ponto de entrada (tudo, idempotente)
├── update.sh               # git pull + brew + restow + plugins
├── Brewfile                # a fonte da verdade dos programas
├── scripts/
│   ├── lib.sh              # helpers de log/cor
│   ├── 00-homebrew.sh
│   ├── 10-brew-bundle.sh
│   ├── 20-stow.sh          # symlinks (com backup de conflitos)
│   └── 30-post.sh          # frameworks, agente, identidade
├── stow/                   # cada pasta = 1 "pacote" do GNU Stow
│   ├── zsh/                # .zshrc + .zsh/{exports,aliases,flutter,init}.zsh
│   ├── git/                # .gitconfig (+ delta) + .gitignore_global
│   ├── starship/           # prompt Catppuccin
│   ├── ghostty/            # config do terminal
│   ├── zellij/             # config + layouts (dev, flutter)
│   ├── nvim/               # LazyVim + Catppuccin + flutter-tools
│   └── claude/             # CLAUDE.md global (contexto do ambiente)
└── docs/                   # documento de design
```

Cada pacote é um symlink independente — dá para aplicar, remover ou entender um
sem tocar nos outros. Para editar um dotfile, **mexa na origem em
`~/LabOS/stow/...`**, nunca no symlink do `$HOME`.

---

## ✦ Identidade & segredos

Nada sensível vai para o repositório. Na primeira execução, o `install.sh`
pergunta seu nome/email e grava em **`~/.gitconfig.local`** (fora do
versionamento). O `.gitconfig` versionado só faz `include` desse arquivo.
Overrides específicos da máquina vão em **`~/.zshrc.local`**.

---

## ✦ Como estender

- **Novo programa?** adicione ao `Brewfile` e rode `labos-update`.
- **Nova config?** crie o arquivo dentro do pacote em `stow/<pacote>/` e rode
  `./install.sh --dotfiles`.
- **Novo pacote?** crie `stow/<nome>/` espelhando o caminho a partir do `$HOME`
  e inclua o nome no array `PACKAGES` de `scripts/20-stow.sh`.

---

## ✦ Roadmap

- [ ] Fase 2 — camada remota: **Tailscale + mosh** (acessar as sessões de
      qualquer lugar).
- [ ] `macos/defaults.sh` — ajustes finos do sistema (teclado, Finder…).
- [ ] Múltiplos agentes de IA coordenados em painéis.

---

<div align="center">
<sub>Feito com foco e teclado por <b>Henrique Paixão</b> · MIT</sub>
</div>
