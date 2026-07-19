#!/usr/bin/env zsh
# AntaresOS · statusline — serviços locais (para zjstatus command_*)
# ✓ = porta em LISTEN, ✗ = fora. Instantâneo (lsof, sem timeout).

_up() { lsof -nP -iTCP:"$1" -sTCP:LISTEN &>/dev/null && print -n "✓" || print -n "✗"; }

print -n "api$(_up 8080) pg$(_up 5432) redis$(_up 6379)"
