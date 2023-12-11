import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/classificacaoManga.dart';
import 'package:mangafaver/widgets/notaManga.dart';
import 'package:mangafaver/widgets/BotaoFavorito.dart';

class dadosClassificacaoGeral extends StatelessWidget {
  final String mediaNota;
  final String mangaId;
  final String userToken;
  final bool isFavorited;
  final VoidCallback toggleFavorite;

  const dadosClassificacaoGeral({
    Key? key,
    required this.mediaNota,
    required this.mangaId,
    required this.userToken,
    required this.isFavorited,
    required this.toggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 70.0,
              right: 180.0,
            ),
            child: Column(
              children: [
                BotaoFavorito(
                    onPressed: toggleFavorite, isFavorited: isFavorited),
                SizedBox(height: 10.0),
                notaManga(
                  mediaNota: mediaNota,
                ),
                SizedBox(height: 10.0),
                classificacaoManga(mangaId: mangaId, userFavorite: isFavorited),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              BotaoFavorito(
                onPressed: toggleFavorite,
                isFavorited: isFavorited,
              ),
              SizedBox(height: 10.0),
              notaManga(
                mediaNota: mediaNota,
              ),
              SizedBox(height: 10.0),
              classificacaoManga(mangaId: mangaId, userFavorite: isFavorited),
            ],
          );
        }
      },
    );
  }
}
