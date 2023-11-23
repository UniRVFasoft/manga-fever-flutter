import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BotaoAdicionarCategoria extends StatefulWidget {
  final double size;
  final double iconSize;
  final Color buttonColor;
  final Function(String) onPressed;

  const BotaoAdicionarCategoria({
    Key? key,
    this.size = 50.0,
    this.iconSize = 30.0,
    this.buttonColor = const Color(0XFFFF9900),
    required this.onPressed,
  }) : super(key: key);

  @override
  _BotaoAdicionarCategoriaState createState() =>
      _BotaoAdicionarCategoriaState();
}

class _BotaoAdicionarCategoriaState extends State<BotaoAdicionarCategoria> {
  List<String> categorias = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://manga-fever-backend-production.up.railway.app/categorias'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> fetchedCategories =
          data.map((item) => item['descricao'].toString()).toList();

      setState(() {
        categorias = fetchedCategories;
      });
    } else {
      print('Erro ao carregar categorias: ${response.statusCode}');
      // Se houver um erro, você pode usar as categorias padrão ou lidar com o erro de outra forma
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: widget.buttonColor,
        child: PopupMenuButton<String>(
          onSelected: (String value) {
            widget.onPressed(value);
          },
          child: Icon(
            Icons.add,
            size: widget.iconSize,
          ),
          itemBuilder: (BuildContext context) => categorias
              .map(
                (categoria) => PopupMenuItem<String>(
                  value: categoria,
                  child: Text(categoria),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
