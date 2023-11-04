import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mangafaver/widgets/FavoritarManga.dart';

class NotasManga extends StatelessWidget {
  final double nota;
  final String imageUrl;
  final bool isFavorito;

  const NotasManga({
    required this.nota,
    required this.imageUrl,
    required this.isFavorito,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(imageUrl),
                  ),
                  FavoritarManga(
                    isFavorito: isFavorito,
                    onPressed: () {},
                  ),
                ],
              ),
              const Padding(
                //Espaço entre a imagem e as estrelas.
                padding: EdgeInsets.only(top: 8),
              ),
              //Implementação das estrelas de acordo com a nota.
              RatingBar.builder(
                initialRating: nota,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ),
        //Nota em forma de número.
        Positioned(
          top: 200,
          right: 60,
          left: 60,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 43,
              height: 25,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0XFF0066FF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  nota.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}