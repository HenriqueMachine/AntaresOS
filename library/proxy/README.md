# Antares Proxy — inspeção de tráfego

Baseado no [mitmproxy](https://mitmproxy.org) (o equivalente open-source e
keyboard-driven do Charles).

## Comandos (`antares proxy …`)
| Comando | Faz |
|---|---|
| `antares proxy` | sobe a TUI (auto-salva os flows) |
| `antares proxy web` | interface no browser (mitmweb) |
| `antares proxy mock` | sobe com o addon de mock/rewrite |
| `antares proxy open [arq]` | reabre/replaya flows salvos (fzf se vazio) |
| `antares proxy cert` | mostra o CA cert e como confiar |
| `antares proxy android` | aponta o emulador e instala o cert |
| `antares proxy ios` | confia no cert no simulador iOS |
| `antares proxy device` | instruções p/ device físico (IP do Mac) |
| `antares proxy off` | remove o proxy do emulador |
| `pxy` | abre a layout Zellij dedicada |

## Mock / Rewrite (Map Local do Charles)
Edite `mocks.json` — quando uma request casa (`match` = substring **ou** regex na
URL), o proxy responde localmente sem ir ao servidor:

```json
{ "enabled": true, "match": "/users/\\d+$", "status": 200,
  "headers": {"Content-Type": "application/json"}, "body_file": "mocks/user.json" }
```

Rode com `antares proxy mock`. Corpo inline via `body`, ou arquivo via `body_file`
(relativo a este diretório).

## Flutter
O Flutter ignora proxy/CA do sistema. Use o snippet **`flproxy`** (Codex) para o
app em debug passar pelo proxy e aceitar o cert do mitmproxy.
