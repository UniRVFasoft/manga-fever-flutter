import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangafaver/widgets/Appbar2.dart'; 

void main() {
  testWidgets('Teste de pesquisa de mangá por título',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(appBar: AppBar2())));

    Finder searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    // Simula a digitação de um título de mangá no campo de pesquisa
    await tester.enterText(searchField, 'One Piece');

    // Encontra e simula o botão de pesquisa
    Finder searchButton = find.byIcon(Icons.search);
    expect(searchButton, findsOneWidget);
    await tester.tap(searchButton);

    // Espera a conclusão da animação de transição de tela
    await tester.pumpAndSettle();

    // Verifica se a tela de resultados de pesquisa foi carregada corretamente
    expect(
        find.text('Resultados da pesquisa para "One Piece"'), findsOneWidget);
  });
}
