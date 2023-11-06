import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/appBar.dart';
import 'package:mangafaver/widgets/BotaoFavorito.dart';
import 'package:mangafaver/widgets/campoCategoria.dart';
import 'package:mangafaver/widgets/classificacaoManga.dart';
import 'package:mangafaver/widgets/dadosClassificacaoGeral.dart';
import 'package:mangafaver/widgets/DadosMangaGeral.dart';
import 'package:mangafaver/widgets/descricaoManga.dart';
import 'package:mangafaver/widgets/notaManga.dart';
import 'package:mangafaver/widgets/tituloManga.dart';

import 'registerScreen.dart';
import 'package:flutter/material.dart';

class MangaScreen extends StatelessWidget {
  const MangaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Defina a largura com base nas dimensões da tela, com limite máximo
    final containerMaxWidth = screenWidth * 0.8; // 80% da largura da tela

    // Defina um limite máximo para largura
    final maxWidth = 800.0; // Largura máxima desejada

    double containerHeight; // Altura a ser determinada

    if (screenWidth >= 600) {
      // Tela maior, use uma altura menor
      containerHeight = 800.0;
    } else {
      // Tela menor, use uma altura maior
      containerHeight = 1200.0;
    }

    final containerWidth =
        containerMaxWidth < maxWidth ? containerMaxWidth : maxWidth;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        appBar: AppBar(
          backgroundColor: Color(0xFF1A1A1A),
          title: Text('Manga Screen'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1,
                vertical: screenHeight * 0.1,
              ),
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.85,
                maxHeight: containerHeight,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF222222),
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 600) {
                    return Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centralize na horizontal
                      children: [
                        DadosMangaGeral(
                          containerWidth: containerWidth,
                          containerHeight: containerHeight,
                        ),
                        dadosClassificacaoGeral(),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centralize na vertical
                      children: [
                        DadosMangaGeral(
                          containerWidth: containerWidth,
                          containerHeight: containerHeight,
                        ),
                        dadosClassificacaoGeral(),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
