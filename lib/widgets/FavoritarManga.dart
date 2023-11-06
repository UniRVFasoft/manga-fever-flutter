import 'package:flutter/material.dart';

class FavoritarManga extends StatefulWidget {
  final bool isFavorito;
  final VoidCallback? onPressed;

  const FavoritarManga({
    Key? key,
    required this.isFavorito,
    this.onPressed,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoritarMangaState createState() => _FavoritarMangaState();
}

class _FavoritarMangaState extends State<FavoritarManga> {
  bool isFavorito = false;

  @override
  void initState() {
    super.initState();
    isFavorito = widget.isFavorito;
  }

  // Lógica de favoritar e tirar o favorito.
  void toggleFavorito() {
    setState(() {
      isFavorito = !isFavorito;
    });
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorito ? Icons.favorite : Icons.favorite_border,
        color: const Color(0XFFFF9900),
      ),
      onPressed: toggleFavorito,
      iconSize: 30,
    );
  }
}
