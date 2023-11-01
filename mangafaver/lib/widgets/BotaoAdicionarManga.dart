import 'package:flutter/material.dart';

class BotaoAdicionarManga extends StatelessWidget {
  final double size;
  final Color buttonColor;
  final VoidCallback? onPressed;

  const BotaoAdicionarManga({
    Key? key,
    this.size = 50.0,
    this.buttonColor = const Color(0XFFFF9900),
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: buttonColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
