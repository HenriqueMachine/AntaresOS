# AntaresOS · flutter.zsh

if command -v fvm >/dev/null 2>&1; then
  alias flutter='fvm flutter'
  alias dart='fvm dart'
fi

alias fl='flutter'
alias fpg='flutter pub get'
alias fpu='flutter pub upgrade'
alias frun='flutter run'
alias fclean='flutter clean && flutter pub get'
alias fdoc='flutter doctor -v'
alias fdev-emu='flutter emulators --launch'
alias fbr='flutter pub run build_runner build --delete-conflicting-outputs'
alias fbw='flutter pub run build_runner watch --delete-conflicting-outputs'
alias fdevices='flutter devices'

fnew() {
  if [[ -z "$1" ]]; then echo "uso: fnew <nome_do_projeto>"; return 1; fi
  flutter create "$1" && cd "$1" && flutter pub get
}
