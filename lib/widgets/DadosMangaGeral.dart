import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/campoCategoria.dart';
import 'package:mangafaver/widgets/descricaoManga.dart';
import 'package:mangafaver/widgets/tituloManga.dart';

class DadosMangaGeral extends StatelessWidget {
  const DadosMangaGeral({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
  });

  final double containerWidth;
  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Verificar a largura disponível na tela
        double screenWidth = constraints.maxWidth;

        if (screenWidth < 600) {
          // Defina o limite desejado para a mudança de layout
          // Layout em coluna
          return Column(
            children: <Widget>[
              Image.asset(
                'assets/images/capa.jpeg',
                width: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tituloManga(),
                    SizedBox(
                        height:
                            25), // Espaçamento entre tituloManga e CampoCategoria
                    CampoCategoria(texto: 'Ação'),
                    SizedBox(
                        height:
                            15), // Espaçamento entre CampoCategoria e CampoCategoria
                    CampoCategoria(texto: 'Escolar'),
                    SizedBox(
                        height:
                            15), // Espaçamento entre CampoCategoria e CampoCategoria
                    CampoCategoria(texto: 'Shounen'),
                    SizedBox(
                        height:
                            20), // Espaçamento entre CampoCategoria e descricaoManga
                    descricaoManga(),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5), // Reduzir o espaçamento do topo
                    SizedBox(height: 2), // Espaçamento entre o topo e o título
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'assets/images/capa.jpeg',
                              width: 200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tituloManga(),
                              SizedBox(
                                  height:
                                      20), // Espaçamento entre tituloManga e CampoCategoria
                              Row(
                                children: [
                                  CampoCategoria(texto: 'Ação'),
                                  SizedBox(
                                      width:
                                          15), // Espaçamento entre CampoCategoria
                                  CampoCategoria(texto: 'Escolar'),
                                  SizedBox(
                                      width:
                                          15), // Espaçamento entre CampoCategoria
                                  CampoCategoria(texto: 'Shounen'),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      20), // Espaçamento entre Row de CampoCategoria e descricaoManga
                              descricaoManga(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
