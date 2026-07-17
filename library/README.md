# library — comandos, snippets e o Codex

Sua biblioteca pessoal, versionada com o AntaresOS.

```
library/
├── codex/       # dicionário de snippets (.md) → expandem no nvim + busca com snip
│   └── .build/  # gerado (não versionado)
├── cheats/      # cheatsheets executáveis do navi (.cheat) — busca com Ctrl-g
├── snippets/    # trechos de código soltos por tema (.md)
└── notes/       # anotações rápidas (note "texto" cai em inbox.md)
```

## Codex — dicionário de snippets
Cada verbete em `codex/*.md` vira **duas coisas**: um snippet que **expande no
Neovim** (digite o gatilho) e um verbete **buscável** com explicação.

**Formato de um verbete:**
```markdown
## Título do verbete
- trigger: gatilho
- tags: tag1, tag2
- links: https://...

Explicação: o que é, quando e por que usar.

​```dart
o código, com placeholders ${1:assim}
​```
```

**Uso:**
- No nvim: digite o `trigger` (ex: `stless`) e aceite a sugestão → expande.
- **`snip`** — busca (fzf) por título/gatilho, mostra explicação + código no preview e **copia**.
- **`codex-build`** — regenera após editar os `.md` (roda sozinho no `antares update`).

## Outros
- **`Ctrl-g`** — navi: filtra um comando e insere na linha.
- **`note "texto"`** — anexa em `notes/inbox.md`.
- **`lib`** — abre a biblioteca no Neovim.
