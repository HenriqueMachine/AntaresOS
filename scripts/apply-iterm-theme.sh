#!/bin/zsh
# AntaresOS · aplica tema Ice Black no iTerm2
# RODE COM iTerm2 FECHADO (Cmd+Q primeiro, depois: sh apply-iterm-theme.sh)

set -e

PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# Garantir que o iTerm2 não está rodando
if pgrep -x "iTerm2" > /dev/null 2>&1; then
  echo "❌ Feche o iTerm2 completamente (Cmd+Q) antes de rodar este script."
  exit 1
fi

echo "Aplicando tema Ice Black no iTerm2..."

python3 << 'PYEOF'
import plistlib, os, sys

plist = os.path.expanduser("~/Library/Preferences/com.googlecode.iterm2.plist")
with open(plist, "rb") as f:
    p = plistlib.load(f)

profile = p["New Bookmarks"][0]

# ── Fontes ────────────────────────────────────────────────────────────────
profile["Normal Font"]          = "ZedMonoNFM 18"
profile["Non Ascii Font"]       = "FiraCodeNFM-Reg"
profile["Non Ascii Font Size"]  = 18
profile["Use Non-ASCII Font"]   = True
profile["ASCII Ligatures"]      = False

# ── Cursor Guide: ice cyan #3dc9e9 @ 12% ─────────────────────────────────
profile["Cursor Guide Color"] = {
    "Red Component":   0.23922,
    "Green Component": 0.78824,
    "Blue Component":  0.91373,
    "Alpha Component": 0.12,
    "Color Space": "sRGB"
}
profile["Show Cursor Guide"] = True

# ── Background: #080d14 ───────────────────────────────────────────────────
profile["Background Color"] = {
    "Red Component":   0.03137, "Green Component": 0.05098,
    "Blue Component":  0.07843, "Alpha Component": 1.0, "Color Space": "sRGB"
}
# ── Foreground: #b0c9e8 ──────────────────────────────────────────────────
profile["Foreground Color"] = {
    "Red Component":   0.68627, "Green Component": 0.78824,
    "Blue Component":  0.90980, "Alpha Component": 1.0, "Color Space": "sRGB"
}
# ── Cursor: #3dc9e9 ──────────────────────────────────────────────────────
profile["Cursor Color"] = {
    "Red Component":   0.23922, "Green Component": 0.78824,
    "Blue Component":  0.91373, "Alpha Component": 1.0, "Color Space": "sRGB"
}
profile["Cursor Text Color"] = {
    "Red Component":   0.03137, "Green Component": 0.05098,
    "Blue Component":  0.07843, "Alpha Component": 1.0, "Color Space": "sRGB"
}
# ── Selection: #111d2e ────────────────────────────────────────────────────
profile["Selection Color"] = {
    "Red Component":   0.06667, "Green Component": 0.11373,
    "Blue Component":  0.18039, "Alpha Component": 1.0, "Color Space": "sRGB"
}
profile["Selected Text Color"] = {
    "Red Component":   0.68627, "Green Component": 0.78824,
    "Blue Component":  0.90980, "Alpha Component": 1.0, "Color Space": "sRGB"
}

# ── ANSI 0-15: Ice Black palette ─────────────────────────────────────────
ansi = [
    (0.03137, 0.07843, 0.12941),  # 0  Black    #080d14→#081420
    (1.00000, 0.26980, 0.37647),  # 1  Red      #ff4560
    (0.23922, 0.83922, 0.54902),  # 2  Green    #3dd68c
    (1.00000, 0.70588, 0.32941),  # 3  Yellow   #ffb454
    (0.30980, 0.61176, 0.97647),  # 4  Blue     #4f9cf9
    (0.78039, 0.49020, 1.00000),  # 5  Magenta  #c77dff
    (0.23922, 0.78824, 0.91373),  # 6  Cyan     #3dc9e9
    (0.77255, 0.81176, 0.87843),  # 7  White    #c5cfe0
    (0.10196, 0.17647, 0.26275),  # 8  BrBlack  #1a2d43
    (1.00000, 0.26980, 0.37647),  # 9  BrRed
    (0.37647, 0.93333, 0.64706),  # 10 BrGreen  #60eda5
    (1.00000, 0.81176, 0.43922),  # 11 BrYellow #ffcf70
    (0.43922, 0.70588, 1.00000),  # 12 BrBlue   #70b4ff
    (0.87843, 0.63529, 1.00000),  # 13 BrMagenta #e0a2ff
    (0.37647, 0.84706, 0.97255),  # 14 BrCyan   #60d8f8
    (0.68627, 0.78824, 0.90980),  # 15 BrWhite  #b0c9e8
]
for i, (r, g, b) in enumerate(ansi):
    profile[f"Ansi {i} Color"] = {
        "Red Component": r, "Green Component": g,
        "Blue Component": b, "Alpha Component": 1.0, "Color Space": "sRGB"
    }

with open(plist, "wb") as f:
    plistlib.dump(p, f)

print("✅ Tema Ice Black aplicado!")
print(f"   Font principal : ZedMonoNFM 18")
print(f"   Non-ASCII font : FiraCodeNFM-Reg (fix para ícones ?)")
print(f"   Cursor Guide   : ice cyan 12%")
PYEOF

echo ""
echo "✅ Feito! Abra o iTerm2 agora."
