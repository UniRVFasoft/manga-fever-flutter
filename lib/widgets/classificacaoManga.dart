import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class classificacaoManga extends StatefulWidget {
  final String mangaId;

  const classificacaoManga({super.key, 
    required this.mangaId,
  });

  @override
  State<classificacaoManga> createState() => _ClassificacaoState();
}

class _ClassificacaoState extends State<classificacaoManga> {
  int estrelasPreenchidas = 0;

Future<void> enviarClassificacao(int classificacao) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('token');

    if (userToken == null) {
      throw Exception('Token do usuário não encontrado.');
    }

    final int classificacaoManga = classificacao;
    final String apiUrl = 'https://manga-fever-backend-production.up.railway.app/mangas/avaliar/${widget.mangaId}';

    print('ID do Manga: ${widget.mangaId}');
    print('Classificação: $classificacao');
    print('token: $userToken');

    final Map<String, dynamic> requestBody = _buildRequestBody(classificacaoManga);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json', // Defina o tipo de conteúdo para JSON
      },
      body: jsonEncode(requestBody),
    );

    print(jsonEncode(requestBody));

    if (response.statusCode == 200) {
      print('Classificação enviada com sucesso: $classificacaoManga');
    } else {
      throw Exception('Falha ao enviar a classificação. Status: ${response.statusCode}. Mensagem: ${response.body}');
    }
  } catch (error) {
    throw Exception('Erro ao enviar a classificação: $error');
  }
}

Map<String, dynamic> _buildRequestBody(int classificacaoManga) {
  return {
    'classificacao': classificacaoManga,
  };
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
