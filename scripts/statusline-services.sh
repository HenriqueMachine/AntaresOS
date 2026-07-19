#!/usr/bin/env zsh
# AntaresOS · statusline — serviços locais (para zjstatus command_*)
# ✓ = alguma porta do grupo em LISTEN, ✗ = nenhuma. Instantâneo (lsof, sem timeout).
# Grupos cobrem os 2 projetos rodando local OU em docker:
#   pg    → Postgres  (Foodbot 5432 · CourtHub 5433)
#   redis → Redis     (6379)
#   api   → algum back (Foodbot 8080 · CourtHub core 8081 · bff 8090 · gradle local 8080)

_any() {
  local p
  for p in "$@"; do
    lsof -nP -iTCP:"$p" -sTCP:LISTEN &>/dev/null && { print -n "✓"; return; }
  done
  print -n "✗"
}

print -n "pg$(_any 5432 5433) redis$(_any 6379) api$(_any 8080 8081 8090)"
