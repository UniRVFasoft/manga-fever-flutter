import 'package:flutter/material.dart';

class textoTitulo extends StatelessWidget {
  final String titulo;

  const textoTitulo({
    super.key, required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Text(
        titulo,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
