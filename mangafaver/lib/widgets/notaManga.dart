import 'package:flutter/material.dart';

class notaManga extends StatelessWidget {
  final String nota;

  const notaManga({
    super.key,
    required this.nota,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 120,
      child: Center(
        child: Text(
          nota,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFB800),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}
