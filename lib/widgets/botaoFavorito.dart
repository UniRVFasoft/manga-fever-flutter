import 'package:flutter/material.dart';

class BotaoFavorito extends StatefulWidget {
  const BotaoFavorito({
    Key? key,
    this.icon = Icons.add,
    this.text = 'Favoritar',
    this.color = Colors.black,
    this.backgroundColor = const Color(0xFF0066FF),
    this.textColor = Colors.black,
    this.maxWidth = 125.0, // Largura máxima desejada
    this.maxHeight = 50.0, // Altura máxima desejada
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final Color backgroundColor;
  final Color textColor;
  final double maxWidth;
  final double maxHeight;

  @override
  State<BotaoFavorito> createState() => _MyButtonState();
}

class _MyButtonState extends State<BotaoFavorito> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth,
        maxHeight: widget.maxHeight,
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isPressed = !isPressed;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPressed ? Icons.favorite : widget.icon,
              color: isPressed ? widget.textColor : widget.color,
            ),
            SizedBox(width: 10),
            Text(
              isPressed ? 'Favorito' : widget.text,
              style: TextStyle(
                color: isPressed ? widget.textColor : widget.color,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
