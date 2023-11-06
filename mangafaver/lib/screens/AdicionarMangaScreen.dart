import 'package:flutter/material.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/widgets/AppBarHomeScreen.dart';
import 'package:mangafaver/widgets/BotaoAdicionarManga.dart';
import 'package:mangafaver/widgets/CampoTextoCustom.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';

class AdicionarMangaScreen extends StatelessWidget {
  const AdicionarMangaScreen({Key? key}) : super(key: key);

  final double botaoTamanho = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: const AppBarHomeScreen(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          final containerMaxWidth = screenWidth * 0.8;
          final containerMaxHeight = screenHeight * 1.0;

          const maxWidth = 800.0;
          const maxHeight = 625.0;

          final containerWidth =
              containerMaxWidth < maxWidth ? containerMaxWidth : maxWidth;
          final containerHeight =
              containerMaxHeight < maxHeight ? containerMaxHeight : maxHeight;

          return Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: SingleChildScrollView(
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
                      color: const Color(0xFF222222),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const textoTitulo(
                              titulo: 'Adicionar Mangá',
                            ),
                            const campoTexto(descricao: 'Título'),
                            const campoTexto(descricao: 'Link Imagem'),
                            const campoTexto(descricao: 'Classificação'),
                            const CampoTextoCustom(
                              descricao: 'Descrição',
                              maxLines: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFCA3A3A),
                                          ),
                                          child: const Text('CANCELAR',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF008405),
                                          ),
                                          child: const Text('SALVAR',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          //Posição do botão dependendo do tamanho da tela.
                          top: screenWidth <= 600 ? 255 : 255,
                          left: screenWidth <= 600 ? 172 : 212,
                          child: BotaoAdicionarManga(
                            size: botaoTamanho,
                            iconSize: 18.0,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
