import 'package:flutter/material.dart';

class CampoCategoria extends StatelessWidget {
  final String texto;

  CampoCategoria({
    Key? key,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, bottom: 10.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 150, // Defina o tamanho máximo desejado
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  color: Color(0XFFFF9900),
                ),
                child: Center(
                  child: Text(
                    texto,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
