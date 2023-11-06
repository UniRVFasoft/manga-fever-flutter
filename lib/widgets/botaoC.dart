import 'package:flutter/material.dart';

class BotaoC extends StatelessWidget {
  final Widget tela; // Parâmetro para a tela

  BotaoC({
    required this.tela,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => tela, // Use o parâmetro da tela aqui
          ),
        );
      },
      child: Text(
        'Criar conta',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 16,
        ),
      ),
    );
  }
}
