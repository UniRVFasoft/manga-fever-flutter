import 'package:flutter/material.dart';

class BotaoEntrar extends StatelessWidget {
  final VoidCallback? onPressed;
  const BotaoEntrar({
    Key? key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(fontSize: 25), // Tamanho do texto
          ),
          minimumSize: MaterialStateProperty.all<Size>(Size(250, 60)),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xFFE6810B),
          ), // Substitua "Colors.blue" pela cor desejada
        ),
        child: Text('Entrar'),
      ),
    );
  }
}
