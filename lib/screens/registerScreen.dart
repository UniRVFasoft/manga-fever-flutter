import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mangafaver/screens/loginScreen.dart';
import 'package:mangafaver/widgets/appBar.dart';
import 'package:mangafaver/widgets/botaoA.dart';
import 'package:mangafaver/widgets/botaoB.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({Key? key}) : super(key: key);

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _cadastro() async {
    const String apiUrl =
        'https://manga-fever-backend-production.up.railway.app/auth/cadastrar';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'nomeUsuario': 'teste12',
          'email': 'email1@email.com',
          'senha': 'senha123'
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Cadastrado com sucesso!');
      } else {
        print('Erro no cadastro ${response.body}');
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
    final containerMaxHeight = screenHeight * 1.0; // 80% da altura da tela

    // Defina limites máximos para largura e altura
    final maxWidth = 800.0; // Largura máxima desejada
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
        body: SingleChildScrollView(
          child: Center(
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
                      titulo: 'Cadastro de usuário',
                    ),
                    campoTexto(descricao: 'Nome de usuário'),
                    campoTexto(descricao: 'Email'),
                    campoTexto(
                      descricao: 'Senha',
                      obscureText: true,
                    ),
                    campoTexto(
                      descricao: 'Confirmar senha',
                      obscureText: true,
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          botaoA(onPressed: () => _cadastro()),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          BotaoB(
                            texto: '< Retornar ao início',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
