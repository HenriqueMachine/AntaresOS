#!/usr/bin/env bash
# AntaresOS · codex-build — verbetes markdown -> snippets do nvim + índice
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

CODEX="${ANTARES_LIB:-$ANTARES_DIR/library}/codex"

if ! have python3; then
  err "python3 não encontrado — necessário para gerar o Codex."
  exit 1
fi

python3 - "$CODEX" <<'PY'
import json, os, re, sys, glob

codex_dir = sys.argv[1]
out_dir = os.path.join(codex_dir, ".build")
os.makedirs(out_dir, exist_ok=True)

FT_MAP = {"bash": "sh", "shell": "sh", "zsh": "sh"}

entries = []
langs = {}

for md in sorted(glob.glob(os.path.join(codex_dir, "*.md"))):
    text = open(md, encoding="utf-8").read()
    for part in re.split(r'(?m)^##\s+', text)[1:]:
        lines = part.splitlines()
        title = lines[0].strip()
        meta, prose, code = {}, [], []
        lang, in_code = None, False
        for line in lines[1:]:
            if not in_code:
                m = re.match(r'^-\s+(\w+):\s*(.*)$', line)
                if m and not code:
                    meta[m.group(1)] = m.group(2).strip()
                    continue
                fm = re.match(r'^```(\w+)?', line)
                if fm:
                    in_code = True
                    lang = fm.group(1) or "text"
                    continue
                if line.strip():
                    prose.append(line.rstrip())
            else:
                if line.strip().startswith("```"):
                    break
                code.append(line)
        if not code:
            continue
        prefix = meta.get("trigger", title.lower())
        ft = FT_MAP.get(lang, lang)
        description = " ".join(prose).strip()
        langs.setdefault(ft, {})[title] = {
            "prefix": prefix, "body": code, "description": description,
        }
        entries.append({
            "title": title, "trigger": prefix, "lang": ft,
            "tags": meta.get("tags", ""), "links": meta.get("links", ""),
            "description": description, "body": "\n".join(code),
        })

contributes = []
for ft, snips in langs.items():
    fn = f"{ft}.json"
    json.dump(snips, open(os.path.join(out_dir, fn), "w", encoding="utf-8"),
              ensure_ascii=False, indent=2)
    contributes.append({"language": ft, "path": f"./{fn}"})

pkg = {"name": "antares-codex", "contributes": {"snippets": contributes}}
json.dump(pkg, open(os.path.join(out_dir, "package.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=2)
json.dump(entries, open(os.path.join(out_dir, "index.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=2)
print(f"{len(entries)} verbetes · {len(langs)} linguagem(ns)")
PY

ok "Codex gerado em $CODEX/.build"
