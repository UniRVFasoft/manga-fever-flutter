import 'package:flutter/material.dart';
import 'package:mangafaver/screens/HomeScreen.dart';

class AppBar1 extends StatelessWidget {
  const AppBar1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(searchTerm: ''), // Se necessário, passe um searchTerm aqui
      ),
    );
  },
  child: Row(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(searchTerm: ''), // Se necessário, passe um searchTerm aqui
            ),
          );
        },
        child: Image.asset(
          'assets/images/icon.png',
          width: 40,
        ),
      ),
      Padding(padding: EdgeInsets.only(left: 10)),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(searchTerm: ''), // Se necessário, passe um searchTerm aqui
            ),
          );
        },
        child: Text(
          'Manga\nFever',
          style: TextStyle(fontFamily: 'KronaOne-Regular'),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  ),
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
