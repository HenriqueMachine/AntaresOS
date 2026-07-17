# Dart

## Classe básica
- trigger: class
- tags: dart, oop

Uma classe simples com construtor e um campo final. Base para models e serviços.

```dart
class ${1:Nome} {
  final ${2:String} ${3:valor};

  const ${1:Nome}(this.${3:valor});
}
```

## StatelessWidget
- trigger: stless
- tags: flutter, widget
- links: https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html

Widget sem estado. Use quando a UI só depende dos parâmetros recebidos e não muda
sozinha ao longo do tempo.

```dart
class ${1:MeuWidget} extends StatelessWidget {
  const ${1:MeuWidget}({super.key});

  @override
  Widget build(BuildContext context) {
    return ${2:const Placeholder()};
  }
}
```

## StatefulWidget
- trigger: stful
- tags: flutter, widget
- links: https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html

Widget com estado interno mutável. Use quando a UI muda em resposta a eventos
(input, timers, animações) e precisa chamar setState.

```dart
class ${1:MeuWidget} extends StatefulWidget {
  const ${1:MeuWidget}({super.key});

  @override
  State<${1:MeuWidget}> createState() => _${1:MeuWidget}State();
}

class _${1:MeuWidget}State extends State<${1:MeuWidget}> {
  @override
  Widget build(BuildContext context) {
    return ${2:const Placeholder()};
  }
}
```

## Enum aprimorado
- trigger: enum
- tags: dart

Enum com campos e métodos (enhanced enum, Dart 2.17+). Ótimo para estados com
dados associados.

```dart
enum ${1:Status} {
  ${2:ativo}(${3:'ativo'}),
  ${4:inativo}(${5:'inativo'});

  const ${1:Status}(this.label);
  final String label;
}
```

## Model com fromJson/toJson
- trigger: model
- tags: dart, json

Model imutável com serialização manual de JSON. Base para respostas de API.

```dart
class ${1:Modelo} {
  final ${2:int} ${3:id};

  const ${1:Modelo}({required this.${3:id}});

  factory ${1:Modelo}.fromJson(Map<String, dynamic> json) => ${1:Modelo}(
        ${3:id}: json['${3:id}'] as ${2:int},
      );

  Map<String, dynamic> toJson() => {
        '${3:id}': ${3:id},
      };
}
```

## Result selado (sucesso/erro)
- trigger: result
- tags: dart, pattern, error-handling

Tipo selado para retornar sucesso ou erro sem lançar exceptions. Force o tratamento
dos dois casos com pattern matching (switch).

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
```

## Teste de widget
- trigger: twidget
- tags: flutter, test

Esqueleto de teste de widget com pump e um matcher.

```dart
testWidgets('${1:descrição}', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: ${2:MeuWidget}()));

  expect(find.text('${3:texto}'), findsOneWidget);
});
```
