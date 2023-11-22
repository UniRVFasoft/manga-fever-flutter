import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/widgets/AppBarHomeScreen.dart';
import 'package:mangafaver/widgets/BotaoAdicionarClassificacao.dart';
import 'package:mangafaver/widgets/CampoTextoDescricao.dart';
import 'package:mangafaver/widgets/campoCategoria.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';
import 'package:http/http.dart' as http;

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
  List<String> opcaoSelecionada = [];
  

  Future<void> _adicionarManga() async {
    const String apiUrl = 'https://manga-fever-backend-production.up.railway.app/mangas/create';
    List<String> classificacao = opcaoSelecionada.toList();
    
    try {
      final Map<String, dynamic> mangaData = {
        'titulo': tituloController.text,
        'descricao': descriptionController.text,
        'imagem': imagemController.text,
        'categorias': classificacao,
      };

      final String requestBody = jsonEncode(mangaData);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhkYWU0ZjdkLWU2ZmEtNGFjYy1hMWY4LTMxZTVkYTc3ZTlmZCIsInNlbmhhIjoiJDJiJDEwJHlOd2lPTnBua1ExY3Q5M0I3dU82Ni5jZGZPc0hWNm8yMUlxU1lGd3UzMGRvMkNsWU9pQm8uIiwiZW1haWwiOiJwZWRyb0BwZWRyby5wZWRybyIsIm5vbWVVc3VhcmlvIjoicGVkcmluaG8iLCJpc0FkbWluIjp0cnVlLCJjcmlhZG9FbSI6IjIwMjMtMTEtMjJUMTE6MDE6MTIuODgwWiIsImlhdCI6MTcwMDY1MTE0NiwiZXhwIjoxNzAwNjU0NzQ2fQ.MPmBnGdWKPZe4oi85bEDIUAmDc1-TXyP3i_O3Nf4m1I',
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Mangá adicionado com sucesso!');

        // Retorna para a tela anterior (HomeScreen) e passa os dados do novo mangá como parâmetro
        Navigator.pop(context, {
          'titulo': tituloController.text,
          'descricao': descriptionController.text,
          'imagem': imagemController.text,
          'classificacao': opcaoSelecionada,
        });
      } else {
        print('Erro ao adicionar o mangá ${response.body}');
        // Trate o erro adequadamente
      }
    } catch (error) {
      print('Erro: $error');
    }
  }

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
          const maxHeight = 590.0;

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
                                horizontal: 60,
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
                                        SizedBox(
                                            width: screenWidth *
                                                0.03), // Ajuste a distância do lado direito conforme necessário
                                      const Text(
                                        'Classificação',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Adiciona um espaço de 8 pixels entre o texto e o botão
                                      BotaoAdicionarClassificacao(
                                        size: botaoTamanho,
                                        iconSize: 18.0,
                                        onPressed: (opcao) {
                                          setState(() {
                                            opcaoSelecionada.add(opcao);
                                            
                                          });
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
                                     child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          for (var item in opcaoSelecionada)
                                           CampoCategoria(texto: item),
                                           SizedBox(height: 10, width: 10,),
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
