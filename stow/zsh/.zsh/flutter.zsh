# ═══════════════════════════════════════════════════════════════
#  LabOS · flutter.zsh — kit mobile (Flutter / Dart / fvm)
# ═══════════════════════════════════════════════════════════════

# fvm gerencia versões do Flutter por projeto.
# Se o fvm estiver presente, roteia `flutter`/`dart` pelo fvm.
if command -v fvm >/dev/null 2>&1; then
  alias flutter='fvm flutter'
  alias dart='fvm dart'
fi

# ── Atalhos ─────────────────────────────────────────────────────
alias fl='flutter'
alias fpg='flutter pub get'
alias fpu='flutter pub upgrade'
alias frun='flutter run'
alias fclean='flutter clean && flutter pub get'
alias fdoc='flutter doctor -v'
alias fdev-emu='flutter emulators --launch'   # abre o primeiro emulador
alias fbr='flutter pub run build_runner build --delete-conflicting-outputs'
alias fbw='flutter pub run build_runner watch --delete-conflicting-outputs'
alias fdevices='flutter devices'

# ── Helper: cria projeto já organizado ──────────────────────────
fnew() {
  if [[ -z "$1" ]]; then echo "uso: fnew <nome_do_projeto>"; return 1; fi
  flutter create "$1" && cd "$1" && flutter pub get
}
