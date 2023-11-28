import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CampoCategoria2 extends StatefulWidget {
  final String categoryId;

  CampoCategoria2({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  _CampoCategoria2State createState() => _CampoCategoria2State();
}

class _CampoCategoria2State extends State<CampoCategoria2> {
  late String categoryDescription = '';

  @override
  void initState() {
    super.initState();
    fetchCategoryDescription();
  }

  Future<void> fetchCategoryDescription() async {
    final url = Uri.parse(
        'https://manga-fever-backend-production.up.railway.app/categorias/${widget.categoryId}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = response.body;
        // Verifica se a resposta não está vazia
        if (jsonResponse.isNotEmpty) {
          final categoryData = json.decode(jsonResponse);
          if (categoryData.containsKey('descricao')) {
            setState(() {
              categoryDescription = categoryData['descricao'];
            });
          } else {
            throw Exception('Descrição da categoria não encontrada');
          }
        } else {
          throw Exception('Resposta vazia da API');
        }
      } else {
        throw Exception('Falha ao carregar a categoria');
      }
    } catch (error) {
      throw Exception('Erro: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 150,
      ),
      child: Container(
        margin: EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: Color(0XFFFF9900),
              ),
              child: Center(
                child: Text(
                  categoryDescription.isNotEmpty
                      ? categoryDescription
                      : 'Carregando...',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
