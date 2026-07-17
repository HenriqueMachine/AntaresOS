# library — comandos e snippets

Sua biblioteca pessoal, versionada com o AntaresOS.

```
library/
├── cheats/      # cheatsheets executáveis do navi (.cheat) — busca com Ctrl-g
├── snippets/    # trechos de código por tema (.md)
└── notes/       # anotações rápidas (note "texto" cai em inbox.md)
```

## Uso
- **`Ctrl-g`** — abre o navi: filtra um comando e insere na linha (placeholders `<...>` são editáveis).
- **`note "texto"`** — anexa uma linha em `notes/inbox.md` (com data/hora). Sem texto, abre o arquivo no nvim.
- **`lib`** — abre esta pasta no Neovim.
- Na sessão `dev`, a **tab `lib`** já abre a biblioteca no editor.

## Adicionar um cheat
Edite/crie um arquivo em `cheats/*.cheat`:
```
% tag1, tag2

# Descrição do comando
o comando aqui <placeholder>
```
