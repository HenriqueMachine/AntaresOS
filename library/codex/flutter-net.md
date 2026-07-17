# Flutter — rede

## Proxy de debug (mitmproxy)
- trigger: flproxy
- tags: flutter, dart, network, mitmproxy, debug
- links: https://api.flutter.dev/flutter/dart-io/HttpOverrides-class.html

Em debug, roteia todo o HttpClient do app pelo mitmproxy e aceita o certificado dele.
Necessário porque o Dart/Flutter IGNORA o proxy e o CA do sistema por padrão.
Host: emulador Android = 10.0.2.2 · simulador iOS = 127.0.0.1 · device = IP do Mac.

```dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class _DevProxy extends HttpOverrides {
  final String host;
  final int port;
  _DevProxy(this.host, this.port);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = (uri) => 'PROXY $host:$port;'
      ..badCertificateCallback = (cert, host, port) => true; // só em debug!
  }
}

void enableDevProxy({String host = '10.0.2.2', int port = 8080}) {
  if (kDebugMode) {
    HttpOverrides.global = _DevProxy(host, port);
  }
}
```
