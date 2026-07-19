#!/usr/bin/env zsh
# AntaresOS · scratch-init — cria ~/.scratch com arquivos-semente (idempotente)

local dir="${SCRATCH_DIR:-$HOME/.scratch}"
mkdir -p "$dir"

_seed() { [[ -f "$dir/$1" ]] || print -r -- "$2" > "$dir/$1"; }

_seed scratch.kt      'fun main() {
    println("kotlin scratch ✦")
    // rode este arquivo:  kotlinc -script scratch.kt   (ou cole no REPL kotlinc)
}'

_seed scratch.clj     ';; clojure scratch ✦  — cole no REPL clj, ou:  clj -M scratch.clj
(println "clojure scratch ✦")'

_seed scratch.dart    '// dart scratch ✦  — Dart não tem REPL; rode:  dart run scratch.dart
void main() {
  print("dart scratch ✦");
}'

_seed scratch.py      '# python scratch ✦  — no nvim: <leader>r roda a seleção (sniprun)
print("python scratch ✦")'

_seed scratch.sh      '#!/usr/bin/env bash
# bash scratch ✦  — <leader>r no nvim roda a linha/seleção
echo "bash scratch ✦"'

print "scratch pronto em $dir"
