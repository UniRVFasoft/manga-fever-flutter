import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangafaver/screens/HomeScreen.dart'; // Importe o arquivo HomeScreen.dart

void main() {
  testWidgets('Verifica se a lista está sendo exibida',
      (WidgetTester tester) async {
    // Cria o widget que contém a tela HomeScreen
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(
            searchTerm:
                ''), // Inicializa a tela HomeScreen com um searchTerm vazio
      ),
    );

    // Aguarda a renderização dos widgets
    await tester.pumpAndSettle();

    // Verifica se o widget de lista está presente na tela
    expect(find.byType(GridView), findsOneWidget);
  });
}
