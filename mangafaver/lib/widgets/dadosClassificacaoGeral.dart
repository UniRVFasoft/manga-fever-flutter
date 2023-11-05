import 'package:flutter/material.dart';
import 'package:mangafaver/widgets/BotaoFavorito.dart';
import 'package:mangafaver/widgets/classificacaoManga.dart';
import 'package:mangafaver/widgets/notaManga.dart';

class dadosClassificacaoGeral extends StatelessWidget {
  const dadosClassificacaoGeral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BotaoFavorito(),
          SizedBox(height: 10.0),
          notaManga(
            nota: '4.8',
          ),
          SizedBox(height: 10.0),
          classificacaoManga(classificacao: 4),
        ],
      ),
    );
  }
}
