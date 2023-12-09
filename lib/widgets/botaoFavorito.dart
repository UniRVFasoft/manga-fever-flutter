import 'package:flutter/material.dart';

class BotaoFavorito extends StatelessWidget {
  final bool isFavorited;
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color color;
  final Color backgroundColor;
  final Color textColor;
  final double maxWidth;
  final double maxHeight;

  const BotaoFavorito({
    Key? key,
    required this.isFavorited,
    required this.onPressed,
    this.icon = Icons.add,
    this.text = 'Favoritar',
    this.color = Colors.black,
    this.backgroundColor = const Color(0xFF0066FF),
    this.textColor = Colors.black,
    this.maxWidth = 125.0,
    this.maxHeight = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFavorited ? Icons.favorite : icon,
              color: isFavorited ? Colors.red : color,
            ),
            SizedBox(width: 10),
            Text(
              isFavorited ? 'Favorito' : text,
              style: TextStyle(
                color: isFavorited ? Colors.red : textColor,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          primary: isFavorited ? Colors.yellow : backgroundColor,
        ),
      ),
    );
  }
}
