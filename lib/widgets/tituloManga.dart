import 'package:flutter/material.dart';

class TituloManga extends StatelessWidget {
  const TituloManga({
    Key? key,
    required this.textoTitulo,
  }) : super(key: key);

  final String textoTitulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        textoTitulo,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
