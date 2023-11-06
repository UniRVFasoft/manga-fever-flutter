import 'package:flutter/material.dart';

class tituloManga extends StatelessWidget {
  const tituloManga({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Tokyo Revengers:  Baji Keisuke kara no Tegami',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}