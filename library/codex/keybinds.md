# Keybinds

## Zellij — atalhos
- trigger: keys-zellij
- tags: zellij, keybind

Atalhos essenciais do Zellij. A barra inferior também mostra os modos.

```text
Alt n              novo painel
Alt ←↑↓→ / hjkl    mover foco entre painéis
Alt + / Alt -      redimensionar painel
Ctrl p depois f    zoom (painel em tela cheia)
Ctrl p depois x    fechar painel
Ctrl t depois n    nova aba   ·   Ctrl t + setas: trocar de aba
Ctrl s             modo scroll / busca (/ busca)
Ctrl o depois d    detach (deixa a sessão viva; volta com dev)
Ctrl q             encerrar o Zellij
```

## Neovim — atalhos
- trigger: keys-nvim
- tags: neovim, keybind

Atalhos essenciais do Neovim/LazyVim (líder = Espaço).

```text
Espaço Espaço      buscar arquivos
Espaço /           buscar por conteúdo (grep)
Espaço e           árvore de arquivos
Shift-h / Shift-l  buffer anterior / próximo
Ctrl-h/j/k/l       mover entre janelas
gd / gr / K        definição / referências / documentação
Espaço ca / cr / cf  code action / renomear / formatar
Espaço gg          lazygit
Espaço r           rodar bloco (sniprun)
i / Esc / :w       inserir / normal / salvar
```

## mitmproxy — atalhos (Antares Proxy)
- trigger: keys-proxy
- tags: proxy, mitmproxy, keybind

Atalhos da TUI do mitmproxy (`antares proxy`). Aperte `?` dentro dela para ver todos.

```text
? / q              ajuda (todos os atalhos) / voltar-sair
↑ ↓ (ou j k)       navegar na lista de requests
Enter              abrir o flow (Request / Response / Detail)
Tab                alternar entre as abas do flow
f                  filtro de exibição (~d dominio · ~u /path · ~m GET)
r                  replay do request selecionado
d / z              apagar o flow / limpar a lista toda
w                  salvar os flows num arquivo
e                  editar o flow (método, headers, corpo)
:                  linha de comando (ex: :export.file curl @focus /tmp/req)
```
