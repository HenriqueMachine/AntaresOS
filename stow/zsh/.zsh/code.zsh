# AntaresOS · code.zsh — REPLs e runner de scratch

command -v python3 >/dev/null 2>&1 && alias repl-py='python3'
command -v clj     >/dev/null 2>&1 && alias repl-clj='clj'
command -v kotlinc >/dev/null 2>&1 && alias repl-kt='kotlinc'

# run <arquivo> — executa pela extensão
run() {
  local f="$1"
  [[ -f "$f" ]] || { print "uso: run <arquivo.(py|clj|kts|sh|js)>"; return 1; }
  case "${f:e}" in
    py)       python3 "$f" ;;
    clj|cljc) clj -M "$f" ;;
    kts)      kotlinc -script "$f" ;;
    kt)       kotlinc "$f" -include-runtime -d /tmp/_run.jar && java -jar /tmp/_run.jar ;;
    sh)       bash "$f" ;;
    js)       node "$f" ;;
    *)        print "extensão não suportada: .${f:e}"; return 1 ;;
  esac
}

# scratch <lang> — abre um rascunho no nvim (roda com <leader>r via sniprun ou 'run')
scratch() {
  local ext="${1:-py}"
  local dir="${ANTARES_LIB:-$HOME/Github/AntaresOS/library}/scratch"
  mkdir -p "$dir"
  nvim "$dir/scratch.$ext"
}
