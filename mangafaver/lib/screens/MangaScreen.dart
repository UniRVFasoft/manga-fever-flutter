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

    if (screenWidth >= 1000) {
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
        appBar: AppBarHomeScreen(),
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
                  if (constraints.maxWidth >= 1000) {
                    // Use Row widget with mainAxisAlignment set to spaceBetween
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DadosMangaGeral(
                          containerWidth: containerWidth,
                          containerHeight: containerHeight,
                        ),
                        dadosClassificacaoGeral(),
                      ],
                    );
                  } else {
                    // Use Column widget with mainAxisAlignment set to center
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
