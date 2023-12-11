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
  final String imagemPadrao =
      'https://upload.wikimedia.org/wikipedia/pt/thumb/5/5a/Boku_no_Hero_Academia_Volume_1.png/240px-Boku_no_Hero_Academia_Volume_1.png';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        if (screenWidth < 1038) {
          return Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  mangaData['imagem'] != null
                      ? mangaData['imagem'].toString()
                      : imagemPadrao,
                  width: 200,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    imagemPadrao,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TituloManga(
                      textoTitulo: mangaData['titulo'] != null
                          ? mangaData['titulo'].toString()
                          : 'No title available', // Replace with a default value or handle accordingly
                    ),
                    SizedBox(height: 15),
                    DescricaoManga(
                      textoDescricao: mangaData['descricao'] != null
                          ? mangaData['descricao'].toString()
                          : 'No description available', // Replace with a default value or handle accordingly
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 15.0,
                children: [
                  for (var category
                      in (mangaData['categorias'] as List<dynamic>?)?.take(6) ??
                          [])
                    CampoCategoria2(
                      categoryDescription: category['descricao'].toString(),
                    ),
                ],
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
                    SizedBox(height: 5),
                    SizedBox(height: 2),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.network(
                              mangaData['imagem'],
                              width: 200,
                              height: 330,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Placeholder(
                                  fallbackWidth: 320,
                                  fallbackHeight: 200,
                                  color: Colors.grey,
                                );
                              },

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
                              Row(
                                children: [
                                  for (var category in (mangaData['categorias']
                                              as List<dynamic>?)
                                          ?.take(6) ??
                                      [])
                                    CampoCategoria2(
                                      categoryDescription:
                                          category['descricao'].toString(),
                                    ),
                                ],
                              ),
                              SizedBox(height: 20),
                              DescricaoManga(
                                textoDescricao: mangaData['descricao'] ?? '',
                              ),
                              SizedBox(height: 20),
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