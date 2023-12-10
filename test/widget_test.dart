import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangafaver/screens/LoginScreen.dart';
import 'package:mangafaver/screens/HomeScreen.dart';

void main() {
  testWidgets('Teste de login', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Encontra os campos de texto para nome de usuário e senha
    final usernameField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField && widget.decoration is InputDecoration && widget.decoration!.hintText == 'Nome de usuário',
    );
    final passwordField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField && widget.decoration is InputDecoration && widget.decoration!.hintText == 'Senha',
    );

    // Insere o usuário e a senha nos campos de texto
    await tester.enterText(usernameField.first, 'luciano');
    await tester.enterText(passwordField.first, 'senha123');

    // Encontra e clica no botão de login
    final loginButton = find.widgetWithText(ElevatedButton, 'Entrar');
    await tester.tap(loginButton);
    await tester.pump(); // Aguarda a reação à ação de clique

    // Verifica se a tela de destino após o login é a tela HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}