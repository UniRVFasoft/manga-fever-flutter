import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/widgets/appBar.dart';
import 'package:mangafaver/widgets/BotaoEntrar.dart';
import 'package:mangafaver/widgets/botaoC.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    const String apiUrl = 'http://localhost:3000/auth/entrar';
    ;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'nomeUsuario': usernameController.text,
          'senha': passwordController.text,
        },
      );

      var data = json.decode(response.body);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Autenticado com sucesso!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        print('Erro no login ${response.body}');
        print('Conteúdo do usernameController: ${usernameController.text}');
        print('Conteúdo do passwordController: ${passwordController.text}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Defina a largura e altura com base nas dimensões da tela, com limites máximos
    final containerMaxWidth = screenWidth * 0.8; // 80% da largura da tela
    final containerMaxHeight = screenHeight * 0.8; // 80% da altura da tela

    // Defina limites máximos para largura e altura
    final maxWidth = 700.0; // Largura máxima desejada
    final maxHeight = 800.0; // Altura máxima desejada

    final containerWidth =
        containerMaxWidth < maxWidth ? containerMaxWidth : maxWidth;
    final containerHeight =
        containerMaxHeight < maxHeight ? containerMaxHeight : maxHeight;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        appBar: AppBar(
          backgroundColor: Color(0xFF1A1A1A),
          title: appBar(),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: containerWidth,
              maxHeight: containerHeight,
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF222222),
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
              child: Column(
                children: <Widget>[
                  textoTitulo(
                    titulo: 'Login',
                  ),
                  campoTexto(
                    descricao: 'Nome de usuário',
                    controller: usernameController,
                  ),
                  campoTexto(
                    descricao: 'Senha',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        BotaoEntrar(onPressed: () => _login()),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                  BotaoC(
                    tela: Scaffold(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
