import 'package:flutter/material.dart';

class CampoTextoCustom extends StatelessWidget {
  final String descricao;
  final bool obscureText;
  final int maxLines;

  const CampoTextoCustom({
    Key? key,
    required this.descricao,
    this.obscureText = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.01;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 8, bottom: verticalPadding),
            child: Text(
              descricao,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: TextField(
              obscureText: obscureText,
              maxLines: 3, 
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
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
