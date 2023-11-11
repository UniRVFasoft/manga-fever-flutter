import 'package:flutter/material.dart';

class BotaoAdicionarClassificacao extends StatelessWidget {
  final double size;
  final double iconSize;
  final Color buttonColor;
  final Function(String) onPressed;

  const BotaoAdicionarClassificacao({
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
              value: 'opcao1',
              child: Text('Opção 1'),
            ),
            const PopupMenuItem<String>(
              value: 'opcao2',
              child: Text('Opção 2'),
            ),
            const PopupMenuItem<String>(
              value: 'opcao3',
              child: Text('Opção 3'),
            ),
          ],
        ),
      ),
    );
  }
}
