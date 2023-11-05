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
      margin: EdgeInsets.only(left: 10.0), // Defina a margem inferior
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
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
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
