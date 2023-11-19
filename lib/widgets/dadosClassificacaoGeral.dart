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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return const Padding(
            padding: EdgeInsets.only(
              top: 70.0, 
              right: 180.0, 
            ),
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
        } else {
          return const Column(
            children: [
              BotaoFavorito(),
              SizedBox(height: 10.0),
              notaManga(
                nota: '4.8',
              ),
              SizedBox(height: 10.0),
              classificacaoManga(classificacao: 4),
            ],
          );
        }
      },
    );
  }
}
