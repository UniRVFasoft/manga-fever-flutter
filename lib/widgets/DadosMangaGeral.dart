import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/campoCategoria.dart';
import 'package:mangafaver/widgets/campoCategoria2.dart';
import 'package:mangafaver/widgets/descricaoManga.dart';
import 'package:mangafaver/widgets/tituloManga.dart';

class DadosMangaGeral extends StatelessWidget {
  const DadosMangaGeral({
    Key? key,
    required this.mangaData,
  }) : super(key: key);

  final Map<String, dynamic> mangaData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        if (screenWidth < 1038) {
          // Layout em coluna para telas menores
          return Column(
            children: <Widget>[
              Image.network(
                mangaData['imagem'] ?? 'URL padrão se não houver imagem',
                width: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TituloManga(
                      textoTitulo: mangaData['titulo'] ?? '',
                    ),
                    for (var category
                        in (mangaData['categorias'] as List<dynamic>?)
                                ?.take(3) ??
                            [])
                      Column(
                        children: [
                          CampoCategoria2(categoryId: category.toString()),
                          SizedBox(height: 15),
                        ],
                      ),
                    SizedBox(height: 25),
                    DescricaoManga(
                      textoDescricao: mangaData['descricao'] ?? '',
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // Layout em linha para telas maiores
          return Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    SizedBox(height: 2),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.network(
                              mangaData['imagem'] ??
                                  'URL padrão se não houver imagem',
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
                                textoTitulo: mangaData['titulo'] ?? '',
                              ),
                              SizedBox(height: 20),
                              for (var category
                                  in (mangaData['categorias'] as List<dynamic>?)
                                          ?.take(3) ??
                                      [])
                                Column(
                                  children: [
                                    CampoCategoria2(
                                        categoryId: category.toString()),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              SizedBox(height: 20),
                              DescricaoManga(
                                textoDescricao: mangaData['descricao'] ?? '',
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
