# Dart — tipo Result (sealed)

Padrão para retornar sucesso/erro sem exceptions.

```dart
sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

class Err<T> extends Result<T> {
  final Object error;
  const Err(this.error);
}

// Uso
Result<int> parse(String s) {
  final n = int.tryParse(s);
  return n == null ? Err('inválido') : Ok(n);
}

final r = parse('42');
switch (r) {
  case Ok(:final value):
    print('ok: $value');
  case Err(:final error):
    print('erro: $error');
}
```
