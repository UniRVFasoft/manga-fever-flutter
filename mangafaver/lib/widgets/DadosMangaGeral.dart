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
              SizedBox(width: 15),
              Column(
                children: [
                  tituloManga(),
                  SizedBox(
                      height:
                          10), // Espaçamento entre tituloManga e CampoCategoria
                  CampoCategoria(texto: 'Ação'),
                  SizedBox(
                      height:
                          10), // Espaçamento entre CampoCategoria e CampoCategoria
                  CampoCategoria(texto: 'Escolar'),
                  SizedBox(
                      height:
                          10), // Espaçamento entre CampoCategoria e CampoCategoria
                  CampoCategoria(texto: 'Shounen'),
                  SizedBox(
                      height:
                          10), // Espaçamento entre CampoCategoria e descricaoManga
                  descricaoManga(),
                ],
              ),
            ],
          );
        } else {
          // Layout em linha
          return Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/capa.jpeg',
                  width: 200,
                  alignment: AlignmentDirectional
                      .topStart, // Alinhamento explicitamente definido para o topo esquerdo na vertical
                ),
              ),
              SizedBox(width: 15),
              Column(
                children: [
                  tituloManga(),
                  SizedBox(
                      height:
                          10), // Espaçamento entre tituloManga e Row de CampoCategoria
                  Row(
                    children: [
                      CampoCategoria(texto: 'Ação'),
                      SizedBox(width: 10), // Espaçamento entre CampoCategoria
                      CampoCategoria(texto: 'Escolar'),
                      SizedBox(width: 10), // Espaçamento entre CampoCategoria
                      CampoCategoria(texto: 'Shounen'),
                    ],
                  ),
                  SizedBox(
                      height:
                          10), // Espaçamento entre Row de CampoCategoria e descricaoManga
                  descricaoManga(),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
