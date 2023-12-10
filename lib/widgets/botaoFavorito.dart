import 'package:flutter/material.dart';

class BotaoFavorito extends StatefulWidget {
  final bool isFavorited;
  final VoidCallback onPressed;
  final IconData icon;
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
    this.color = Colors.black,
    this.backgroundColor = const Color(0xFF0066FF),
    this.textColor = Colors.black,
    this.maxWidth = 125.0,
    this.maxHeight = 50.0,
  }) : super(key: key);

  @override
  _BotaoFavoritoState createState() => _BotaoFavoritoState();
}

class _BotaoFavoritoState extends State<BotaoFavorito> {
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _isFavorited = widget.isFavorited;
  }

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
            _isFavorited = !_isFavorited; // Alternar o estado interno
          });
          widget.onPressed(); // Chamada à função onPressed do widget pai
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isFavorited ? Icons.favorite : widget.icon,
              color: _isFavorited ? Colors.amber : widget.color,
            ),
            SizedBox(width: 10),
            Text(
              _isFavorited ? 'Favorito' : 'Favoritar',
              style: TextStyle(
                color: _isFavorited ? Colors.black : widget.textColor,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          primary: _isFavorited ? Colors.orange : widget.backgroundColor,
        ),
      ),
    );
  }
}
