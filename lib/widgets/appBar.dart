import 'package:flutter/material.dart';

class appBar extends StatelessWidget {
  const appBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(
        'assets/images/icon.png',
        width: 40,
      ),
      Padding(padding: EdgeInsets.only(left: 10)),
      Text(
        'Manga\nFever',
        style: TextStyle(fontFamily: 'KronaOne-Regular'),
        textAlign: TextAlign.center,
      ),
      Spacer(),
      IconButton(
        icon: Icon(
          Icons.person_outlined,
          color: Color(0xFFE6810B),
          size: 40,
        ),
        onPressed: () {
          // Adicione aqui a lógica para a ação do botão do ícone
        },
      ),
    ]);
  }
}