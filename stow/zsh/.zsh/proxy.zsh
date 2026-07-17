# AntaresOS · proxy.zsh — Antares Proxy (inspeção de tráfego, estilo Charles)

export PROXY_PORT="${PROXY_PORT:-8080}"
export ANTARES_PROXY_DIR="${ANTARES_PROXY_DIR:-$HOME/.cache/antares/proxy}"

alias pxy='_zj_open proxy proxy'

_antares_proxy() {
  case "$1" in
    ""|start)  _proxy_start "${@:2}" ;;
    web)       _proxy_web "${@:2}" ;;
    mock)      _proxy_mock "${@:2}" ;;
    open)      _proxy_open "$2" ;;
    cert)      _proxy_cert ;;
    android)   _proxy_android ;;
    ios)       _proxy_ios ;;
    device)    _proxy_device ;;
    off)       _proxy_off ;;
    help|-h|--help) _proxy_help ;;
    *) print "antares proxy: '$1' desconhecido — veja 'antares proxy help'"; return 1 ;;
  esac
}

_proxy_help() {
  print "antares proxy — inspeção de tráfego (mitmproxy)"
  print "  start           sobe a TUI (auto-salva os flows)"
  print "  web             interface no browser (mitmweb)"
  print "  mock            sobe com o addon de mock/rewrite"
  print "  open [arquivo]  reabre/replaya flows salvos (fzf se vazio)"
  print "  cert            mostra o CA cert e como confiar"
  print "  android         aponta o emulador e instala o cert"
  print "  ios             confia no cert no simulador iOS"
  print "  device          instruções p/ device físico (IP do Mac)"
  print "  off             remove o proxy do emulador"
}

_proxy_have() { command -v mitmproxy >/dev/null 2>&1 || { print "mitmproxy não instalado — brew install mitmproxy"; return 1; }; }

_proxy_start() {
  _proxy_have || return 1
  mkdir -p "$ANTARES_PROXY_DIR"
  local f="$ANTARES_PROXY_DIR/$(date +%Y%m%d-%H%M%S).flows"
  print "▸ porta $PROXY_PORT · salvando em ${f/#$HOME/~}"
  mitmproxy --listen-port "$PROXY_PORT" -w "$f" "$@"
}

_proxy_web() {
  command -v mitmweb >/dev/null 2>&1 || { print "mitmweb não instalado"; return 1; }
  mitmweb --listen-port "$PROXY_PORT" "$@"
}

_proxy_mock() {
  _proxy_have || return 1
  local addon="${ANTARES_DIR:-$HOME/Github/AntaresOS}/library/proxy/mock_addon.py"
  mkdir -p "$ANTARES_PROXY_DIR"
  local f="$ANTARES_PROXY_DIR/$(date +%Y%m%d-%H%M%S).flows"
  print "▸ mock ativo (${ANTARES_DIR:-~}/library/proxy/mocks.json) · porta $PROXY_PORT"
  mitmproxy --listen-port "$PROXY_PORT" -s "$addon" -w "$f" "$@"
}

_proxy_open() {
  _proxy_have || return 1
  local f="$1"
  if [[ -z "$f" ]]; then
    f=$(ls -t "$ANTARES_PROXY_DIR"/*.flows 2>/dev/null | fzf --prompt='flows ❯ ') || return
  fi
  [[ -f "$f" ]] && mitmproxy -r "$f" || print "arquivo não encontrado: $f"
}

_proxy_cert() {
  local pem="$HOME/.mitmproxy/mitmproxy-ca-cert.pem"
  if [[ ! -f "$pem" ]]; then
    print "cert ainda não gerado — rode 'antares proxy' uma vez para criar ~/.mitmproxy/"
    return 1
  fi
  print "CA cert: $pem"
  print "  Emulador Android:  antares proxy android"
  print "  Simulador iOS:     antares proxy ios"
  print "  Device físico:     antares proxy device"
  print "  macOS (confiar):   sudo security add-trusted-cert -d -r trustRoot \\"
  print "                       -k /Library/Keychains/System.keychain \"$pem\""
}

_proxy_android() {
  command -v adb >/dev/null 2>&1 || { print "adb não encontrado (Android SDK)"; return 1; }
  local host="10.0.2.2"
  adb shell settings put global http_proxy "${host}:${PROXY_PORT}" \
    && print "emulador → proxy ${host}:${PROXY_PORT} ✓"
  local pem="$HOME/.mitmproxy/mitmproxy-ca-cert.pem"
  local cer="$HOME/.mitmproxy/mitmproxy-ca-cert.cer"
  [[ -f "$cer" ]] && adb push "$cer" /sdcard/Download/mitmproxy-ca.cer >/dev/null 2>&1 \
    && print "user cert em /sdcard/Download/mitmproxy-ca.cer"
  # tenta cert de SISTEMA (emulador com -writable-system / rooted)
  if adb root >/dev/null 2>&1 && adb remount >/dev/null 2>&1 && [[ -f "$pem" ]]; then
    local hash; hash=$(openssl x509 -inform PEM -subject_hash_old -in "$pem" 2>/dev/null | head -1)
    if [[ -n "$hash" ]] && adb push "$pem" "/system/etc/security/cacerts/${hash}.0" >/dev/null 2>&1; then
      adb shell chmod 644 "/system/etc/security/cacerts/${hash}.0" 2>/dev/null
      print "cert de SISTEMA instalado (${hash}.0) ✓ — reinicie o app"
    else
      print "não deu p/ instalar cert de sistema — instale o user cert em Ajustes ▸ Segurança"
    fi
  else
    print "emulador não-root — instale o user cert em Ajustes ▸ Segurança ▸ Instalar certificado"
  fi
  print "desligar depois:  antares proxy off"
}

_proxy_ios() {
  local pem="$HOME/.mitmproxy/mitmproxy-ca-cert.pem"
  [[ -f "$pem" ]] || { print "cert não gerado — rode 'antares proxy' uma vez"; return 1; }
  if xcrun simctl keychain booted add-root-cert "$pem" 2>/dev/null; then
    print "cert confiado no simulador iOS (booted) ✓"
  else
    print "nenhum simulador 'booted' — abra o simulador e rode de novo"
  fi
  print "faça o app usar o proxy: snippet 'flproxy' (host 127.0.0.1)"
}

_proxy_device() {
  local ip; ip=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
  print "No device (mesma Wi-Fi):"
  print "  1. Proxy manual → ${ip:-<IP-do-Mac>}:${PROXY_PORT}"
  print "  2. Abra http://mitm.it no device e instale o cert"
}

_proxy_off() {
  command -v adb >/dev/null 2>&1 && adb shell settings put global http_proxy ':0' \
    && print "proxy do emulador removido ✓"
}
