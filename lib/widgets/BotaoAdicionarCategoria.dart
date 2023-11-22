import 'package:flutter/material.dart';

class BotaoAdicionarCategoria extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: buttonColor,
        child: PopupMenuButton<String>(
          onSelected: (String value) {
            onPressed(value);
          },
          child: Icon(
            Icons.add,
            size: iconSize,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Ação',
              child: Text('Ação'),
            ),
            const PopupMenuItem<String>(
              value: 'Suspense',
              child: Text('Suspense'),
            ),
            const PopupMenuItem<String>(
              value: 'Ficção Científica',
              child: Text('Ficção Científica'),
            ),
          ],
        ),
      ),
    );
  }
}
