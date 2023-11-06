import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangafaver/screens/HomeScreen.dart';

void main() {
  testWidgets('Test if ConnectionState.waiting part is accessed',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
    ));

    // Verifique se a parte "ConnectionState.waiting" do if é acessada
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Verifique se outras partes do if não são acessadas
    expect(find.text('Erro: '), findsNothing);
    expect(find.text('Nenhum dado encontrado.'), findsNothing);
    expect(find.text('Dados inválidos'), findsNothing);
  });
}
