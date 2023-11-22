import 'package:flutter/material.dart';

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
  List<String> categorias = [
    'Ação',
    'Suspense',
    'Ficção Científica',
  ];

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
