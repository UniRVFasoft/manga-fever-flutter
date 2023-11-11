import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/appBar.dart';
import 'package:mangafaver/widgets/botaoA.dart';
import 'package:mangafaver/widgets/botaoC.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';

import '../lib/screens/registerScreen.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

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
                  campoTexto(descricao: 'Nome de usuário'),
                  campoTexto(
                    descricao: 'Senha',
                    obscureText: true,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        botaoA(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                  BotaoC(tela: registerScreen())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}