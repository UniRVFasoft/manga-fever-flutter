import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BotaoAdicionarCategoria extends StatefulWidget {
  final double size;
  final double iconSize;
  final Color buttonColor;
  final Function(Categoria) onPressed;

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
  List<Categoria> categorias = [];

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
      List<Categoria> fetchedCategories = data
          .map((item) => Categoria(
                id: item['id'].toString(),
                descricao: item['descricao'].toString(),
              ))
          .toList();

      setState(() {
        categorias = fetchedCategories;
      });
    } else {
      print('Erro ao carregar categorias: ${response.statusCode}');
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
        child: PopupMenuButton<Categoria>(
          onSelected: (Categoria selectedCategory) {
            widget.onPressed(selectedCategory);
          },
          child: Icon(
            Icons.add,
            size: widget.iconSize,
          ),
          itemBuilder: (BuildContext context) => categorias
              .map(
                (categoria) => PopupMenuItem<Categoria>(
                  value: categoria,
                  child: Text(categoria.descricao),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Categoria {
  final String id;
  final String descricao;

  Categoria({required this.id, required this.descricao});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Categoria &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          descricao == other.descricao;

  @override
  int get hashCode => id.hashCode ^ descricao.hashCode;
}
