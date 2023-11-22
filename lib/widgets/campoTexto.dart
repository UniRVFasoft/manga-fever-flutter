import 'package:flutter/material.dart';

class campoTexto extends StatelessWidget {
  final String descricao;
  final bool obscureText;
  final TextEditingController controller;

  const campoTexto({
    Key? key,
    required this.descricao,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.01;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 8, bottom: verticalPadding),
            child: Text(
              descricao,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE6810B),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE6810B),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
