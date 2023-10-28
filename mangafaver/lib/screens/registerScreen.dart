import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/botaoA.dart';
import 'package:mangafaver/widgets/botaoB.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';

import 'loginScreen.dart';

class registerScreen extends StatelessWidget {
  const registerScreen({Key? key}) : super(key: key);

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
          title: Row(children: [
            Image.asset(
              'assets/images/icon.png',
              width: 40,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              'Manga\nFever',
              style: TextStyle(fontFamily: 'KronaOne-Regular'),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.person_outlined,
                color: Color(0xFFE6810B),
                size: 40,
              ),
              onPressed: () {
                // Adicione aqui a lógica para a ação do botão do ícone
              },
            ),
          ]),
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
                        botaoA(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        BotaoB(
                          texto: '< Retornar ao início',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => loginScreen(),
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
