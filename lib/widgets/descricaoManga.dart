import 'package:flutter/material.dart';

class DescricaoManga extends StatelessWidget {
  const DescricaoManga({
    Key? key,
    required this.textoDescricao,
  }) : super(key: key);

  final String textoDescricao;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 200,
      child: Text(
        textoDescricao,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
