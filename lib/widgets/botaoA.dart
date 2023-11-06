import 'package:flutter/material.dart';

class botaoA extends StatelessWidget {
  const botaoA({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          // Adicione o que deseja fazer quando o botão for pressionado aqui
        },
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
