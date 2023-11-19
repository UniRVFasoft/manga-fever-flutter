import 'package:flutter/material.dart';

import 'package:mangafaver/widgets/AppBarHomeScreen.dart';
import 'package:mangafaver/widgets/dadosClassificacaoGeral.dart';
import 'package:mangafaver/widgets/DadosMangaGeral.dart';

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

    if (screenWidth >= 1397) {
      // Tela maior, use uma altura menor
      containerHeight = 850.0;
    } else {
      // Tela menor, use uma altura maior
      containerHeight = 1050.0;
    }

    final containerWidth =
        containerMaxWidth < maxWidth ? containerMaxWidth : maxWidth;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        appBar: AppBarHomeScreen(),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 30,
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.85,
                  maxHeight: containerHeight - 80,
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
                    if (constraints.maxWidth >= 1397) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DadosMangaGeral(
                            imagem: 'assets/images/capa.jpeg',
                            containerWidth: MediaQuery.of(context).size.width,
                            containerHeight: MediaQuery.of(context).size.height,
                            categories: [
                              'Ação',
                              'Escolar',
                              'Shounen'
                            ], // Lista de categorias
                          ),
                          dadosClassificacaoGeral(),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DadosMangaGeral(
                            imagem: 'assets/images/capa.jpeg',
                            containerWidth: MediaQuery.of(context).size.width,
                            containerHeight: MediaQuery.of(context).size.height,
                            categories: ['Ação', 'Escolar', 'Shounen'],
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
      ),
    );
  }
}
