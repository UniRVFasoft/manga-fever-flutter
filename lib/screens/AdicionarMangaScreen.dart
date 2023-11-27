import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/widgets/AppBarHomeScreen.dart';
import 'package:mangafaver/widgets/BotaoAdicionarCategoria.dart';
import 'package:mangafaver/widgets/CampoTextoDescricao.dart';
import 'package:mangafaver/widgets/campoCategoria.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdicionarMangaScreen extends StatefulWidget {
  const AdicionarMangaScreen({Key? key}) : super(key: key);

  @override
  _AdicionarMangaScreenState createState() => _AdicionarMangaScreenState();
}

class _AdicionarMangaScreenState extends State<AdicionarMangaScreen> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imagemController = TextEditingController();

  final double botaoTamanho = 25.0;
  List<Categoria> opcaoSelecionada = [];
  double _containerHeight = 590.0;

  List<Categoria> categorias = [];

  Future<void> _adicionarManga() async {
    const String apiUrl =
        'https://manga-fever-backend-production.up.railway.app/mangas/create';

    final List<String> categoriaIds =
        opcaoSelecionada.map((categoria) => categoria.id).toList();

    final BuildContext currentContext = context; // Store the context

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token != null) {
        final Map<String, dynamic> mangaData = {
          'titulo': tituloController.text,
          'descricao': descriptionController.text,
          'imagem': imagemController.text,
          'categorias': categoriaIds,
        };

        final String requestBody = jsonEncode(mangaData);

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: requestBody,
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            SnackBar(
              content: Text('Mangá adicionado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );

          // Retorna para a tela anterior (HomeScreen) e passa os dados do novo mangá como parâmetro
          Navigator.pop(currentContext, {
            'titulo': tituloController.text,
            'descricao': descriptionController.text,
            'imagem': imagemController.text,
            'classificacao': categoriaIds,
          });
        } else {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            SnackBar(
              content: Text('Erro ao adicionar o mangá. Tente novamente.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Show error message
        ScaffoldMessenger.of(currentContext).showSnackBar(
          SnackBar(
            content: Text('Erro: Token não encontrado. Faça login novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Erro: $error');

      // Show error message
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(
          content: Text('Erro inesperado. Tente novamente mais tarde.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBarHomeScreen(showSearchBar: false),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          final containerMaxWidth = screenWidth * 0.8;
          final containerMaxHeight = _containerHeight;

          const maxWidth = 800.0;
          const maxHeight = 800.0;

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
                            campoTexto(
                              descricao: 'Título',
                              controller: tituloController,
                            ),
                            campoTexto(
                              descricao: 'Link Imagem',
                              controller: imagemController,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (screenWidth > 600)
                                        SizedBox(width: screenWidth * 0.03),
                                      const Text(
                                        'Categorias',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(width: 8),
                                      BotaoAdicionarCategoria(
                                        size: botaoTamanho,
                                        iconSize: 18.0,
                                        onPressed: (opcao) {
                                          if (opcaoSelecionada.length < 6) {
                                            setState(() {
                                              final Categoria categoria =
                                                  Categoria(
                                                id: opcao.id,
                                                descricao: opcao.descricao,
                                              );

                                              if (!categorias.any((c) =>
                                                  c.id == categoria.id)) {
                                                opcaoSelecionada.add(categoria);
                                                categorias.add(categoria);
                                                _containerHeight += 45.0;
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Categoria já adicionada.'),
                                                  ),
                                                );
                                              }
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Você só pode adicionar até 6 categorias. Clique sobre alguma para excluí-la.',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  if (opcaoSelecionada.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: screenWidth > 600
                                            ? screenWidth * 0.03
                                            : 0,
                                        top: 10,
                                      ),
                                      child: Wrap(
                                        spacing:
                                            5.0, // Adjust spacing between items
                                        runSpacing:
                                            5.0, // Adjust spacing between lines
                                        children: [
                                          for (var categoria
                                              in opcaoSelecionada)
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  opcaoSelecionada
                                                      .remove(categoria);
                                                  categorias.removeWhere((c) =>
                                                      c.id == categoria.id);
                                                  _containerHeight -= 45.0;
                                                });
                                              },
                                              child: CampoCategoria(
                                                  texto: categoria.descricao),
                                            ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            CampoTextoDescricao(
                              descricao: 'Descrição',
                              maxLines: 5,
                              controller: descriptionController,
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
                                                    HomeScreen(
                                                  searchTerm: '',
                                                ),
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
                                          onPressed: () {
                                            _adicionarManga();
                                          },
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
