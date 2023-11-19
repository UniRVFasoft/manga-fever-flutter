import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/campoCategoria.dart';
import 'package:mangafaver/widgets/descricaoManga.dart';
import 'package:mangafaver/widgets/tituloManga.dart';

class DadosMangaGeral extends StatelessWidget {
  const DadosMangaGeral({
    Key? key,
    required this.imagem,
    required this.containerWidth,
    required this.containerHeight,
    required this.categories,
  }) : super(key: key);

  final String imagem;
  final double containerWidth;
  final double containerHeight;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Verificar a largura disponível na tela
        double screenWidth = constraints.maxWidth;

        if (screenWidth < 1038) {
          // Defina o limite desejado para a mudança de layout
          // Layout em coluna
          return Column(
            children: <Widget>[
              Image.asset(
                imagem,
                width: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TituloManga(
                      textoTitulo:
                          'Tokyo Revengers: Baji Keisuke kara no Tegami',
                    ),
                    for (var category
                        in categories.take(3)) // Mostrar até 3 categorias
                      Column(
                        children: [
                          CampoCategoria(texto: category),
                          SizedBox(height: 15),
                        ],
                      ),
                    SizedBox(
                        height:
                            25), // Espaçamento entre tituloManga e CampoCategoria
                    DescricaoManga(
                      textoDescricao:
                          'Takemichi é um virgem desempregado de 26 anos que descobre que a garota que ele namorou durante o ensino médio - a única que ele já namorou - morreu. Então, após um acidente ele se encontra de volta ao passado, durante seus anos de ensino médio. Ele promete mudar o futuro e salvar a garota, e para isso, ele planeja subir até o topo da gangue de delinquentes mais brutal da região de Kantou.',
                    ),
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
                              TituloManga(
                                textoTitulo:
                                    'Tokyo Revengers: Baji Keisuke kara no Tegami',
                              ),
                              SizedBox(
                                  height:
                                      20), // Espaçamento entre tituloManga e CampoCategoria
                              for (var category in categories
                                  .take(3)) // Mostrar até 3 categorias
                                Column(
                                  children: [
                                    CampoCategoria(texto: category),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              SizedBox(
                                  height:
                                      20), // Espaçamento entre Row de CampoCategoria e descricaoManga
                              DescricaoManga(
                                textoDescricao:
                                    'Takemichi é um virgem desempregado de 26 anos que descobre que a garota que ele namorou durante o ensino médio - a única que ele já namorou - morreu. Então, após um acidente ele se encontra de volta ao passado, durante seus anos de ensino médio. Ele promete mudar o futuro e salvar a garota, e para isso, ele planeja subir até o topo da gangue de delinquentes mais brutal da região de Kantou.',
                              ),
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
