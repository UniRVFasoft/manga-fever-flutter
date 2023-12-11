import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mangafaver/widgets/Appbar1.dart';
import 'package:mangafaver/widgets/dadosClassificacaoGeral.dart';
import 'package:mangafaver/widgets/DadosMangaGeral.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaScreen extends StatefulWidget {
  final String mangaId;
  final bool userFavorite;

  const MangaScreen(
      {Key? key, required this.mangaId, required this.userFavorite})
      : super(key: key);

  @override
  _MangaScreenState createState() => _MangaScreenState();
}

class _MangaScreenState extends State<MangaScreen> {
  late Map<String, dynamic> mangaDetails = {};
  String? mediaNota;

  bool isFavorited = false;
  late String? userToken;

  void toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('token');

    try {
      String apiUrl =
          'https://manga-fever-backend-production.up.railway.app/mangas/favoritar/${widget.mangaId}';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        print(isFavorited.toString());
        setState(() {
          isFavorited = !isFavorited; // Inverte o estado de favorito
        });
        await fetchMangaDetails();
      } else {
        throw Exception('Falha ao favoritar/desfavoritar o manga');
      }
    } catch (error) {
      throw Exception('Erro: $error');
    }
  }

  Future<void> fetchMangaDetails() async {
    final url = Uri.parse(
        'https://manga-fever-backend-production.up.railway.app/mangas/${widget.mangaId}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          mangaDetails = json.decode(response.body);

          double? nota = mangaDetails['nota'];
          mediaNota = nota != null ? nota.toStringAsFixed(1) : '';
          print('ID do manga recebido: ${widget.mangaId}');
        });
      } else {
        throw Exception('Falha ao carregar detalhes do manga');
      }
    } catch (error) {
      throw Exception('Erro: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchToken();
    fetchMangaDetails();
  }

  Future<void> fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token'); // Obtém o token armazenado
  }

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
        appBar: AppBar(
          backgroundColor: Color(0xFF1A1A1A),
          title: AppBar1(),
        ),
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
                            mangaData: mangaDetails,
                          ),
                          if (mediaNota != null)
                            dadosClassificacaoGeral(
                              mediaNota: mediaNota!,
                              mangaId: widget.mangaId,
                              userToken: userToken ?? '',
                              isFavorited: widget
                                  .userFavorite, // Passando o estado de favorito
                              toggleFavorite:
                                  toggleFavorite, // Passando a função para favoritar/desfavoritar
                            ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DadosMangaGeral(
                            mangaData: mangaDetails,
                          ),
                          if (mediaNota != null)
                            dadosClassificacaoGeral(
                              mediaNota: mediaNota!,
                              mangaId: widget.mangaId,
                              userToken: userToken ?? '',
                              isFavorited: widget
                                  .userFavorite, // Passando o estado de favorito
                              toggleFavorite:
                                  toggleFavorite, // Passando a função para favoritar/desfavoritar
                            ),
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
