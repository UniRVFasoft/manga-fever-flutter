import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangafaver/screens/MangaScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class classificacaoManga extends StatefulWidget {
  final String mangaId;
  final bool userFavorite;

  const classificacaoManga(
      {super.key, required this.mangaId, required this.userFavorite});

  @override
  State<classificacaoManga> createState() => _ClassificacaoState();
}

class _ClassificacaoState extends State<classificacaoManga> {
  int estrelasPreenchidas = 0;
  int currentRating = 0;

  Future<void> enviarClassificacao(int classificacao) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('token');

      if (userToken == null) {
        // Exibir o AlertDialog e retornar sem enviar a classificação
        showLoginAlertDialog();
        return;
      }

      final int classificacaoManga = classificacao;
      final String apiUrl =
          'https://manga-fever-backend-production.up.railway.app/mangas/avaliar/${widget.mangaId}';

      print('ID do Manga: ${widget.mangaId}');
      print('Classificação: $classificacao');
      print('token: $userToken');

      final Map<String, dynamic> requestBody =
          _buildRequestBody(classificacaoManga);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print(jsonEncode(requestBody));

      if (response.statusCode == 200) {
        setState(() {
          estrelasPreenchidas = currentRating;
        });

        print('Classificação enviada com sucesso: $classificacaoManga');
      } else {
        throw Exception(
            'Falha ao enviar a classificação. Status: ${response.statusCode}. Mensagem: ${response.body}');
      }
    } catch (error) {
      throw Exception('Erro ao enviar a classificação: $error');
    }
  }

  Map<String, dynamic> _buildRequestBody(int classificacaoManga) {
    currentRating = classificacaoManga;
    return {
      'classificacao': classificacaoManga,
    };
  }

  void showLoginAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aviso'),
          content: Text('Você precisa estar logado para realizar esta ação.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              GestureDetector(
                onTap: () {
                  enviarClassificacao(i + 1);
                  setState(() {
                    estrelasPreenchidas = i + 1;
                  });
                },
                child: Container(
                  child: Icon(
                    estrelasPreenchidas >= i + 1
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.orange,
                  ),
                  padding: EdgeInsets.all(0.0),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Classificar a Obra',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
