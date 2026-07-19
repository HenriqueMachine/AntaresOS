#!/usr/bin/env zsh
# AntaresOS · courthub-observe — watch de health dos back-ends (Ctrl-C p/ sair)
# CourtHub expõe Actuator (Micrometer + Prometheus + OTLP). Portas locais/docker:
#   core  → :8080 (gradle local) · :8081 (docker)
#   bff   → :8090 (docker) · :8080 (gradle local)

emulate -L zsh

_health() {
  local name="$1" port="$2" j st
  j=$(curl -s -m1 "http://localhost:${port}/actuator/health" 2>/dev/null)
  if [[ -z "$j" ]]; then
    print -P "   %F{8}○ ${name} (:${port}) — fora%f"; return
  fi
  st=$(print -r -- "$j" | jq -r '.status // "?"' 2>/dev/null)
  if [[ "$st" == "UP" ]]; then
    print -P "   %F{green}● ${name} (:${port}) UP%f"
  else
    print -P "   %F{red}● ${name} (:${port}) ${st}%f"
  fi
}

while true; do
  clear
  print -P "%F{green} CourtHub · observability%f   %F{8}$(date +%H:%M:%S)%f"
  print -P "%F{green}────────────────────────────────%f"
  _health "core"       8081
  _health "core-local" 8080
  _health "bff"        8090
  print -P "%F{green}────────────────────────────────%f"
  print -P "   %F{8}prometheus: curl -s :8081/actuator/prometheus | head%f"
  print -P "   %F{8}logs:       make courthub-logs%f"
  print -P "   %F{8}Ctrl-C p/ sair · refresh 3s%f"
  sleep 3
done
