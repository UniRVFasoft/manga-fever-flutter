import 'package:flutter/material.dart';

class classificacaoManga extends StatefulWidget {
  final int classificacao;

  const classificacaoManga({
    required this.classificacao,
  });

  @override
  State<classificacaoManga> createState() => _ClassificacaoState();
}

class _ClassificacaoState extends State<classificacaoManga> {
  int estrelasPreenchidas = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    estrelasPreenchidas = i + 1;
                  });
                },
                child: Container(
                  child: Icon(
                    estrelasPreenchidas >= i + 1
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.orange,
                  ),
                  padding: EdgeInsets.all(0.0),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.0), // Add spacing between the stars and the text
        Text(
          'Classificar a Obra',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
