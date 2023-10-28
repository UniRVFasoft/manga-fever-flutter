import 'package:flutter/material.dart';

class BotaoB extends StatelessWidget {
  final String texto; // Parâmetro para o texto do botão
  final VoidCallback onPressed; // Parâmetro para a ação do botão

  BotaoB({
    required this.texto,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: onPressed, // Use a ação fornecida como retorno de chamada
        child: Text(
          texto,
          style: TextStyle(
            color: Color(0xFFAEAEAE),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
