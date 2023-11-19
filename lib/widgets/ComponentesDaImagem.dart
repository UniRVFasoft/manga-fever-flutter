import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mangafaver/widgets/FavoritarManga.dart';

class ComponentesDaImagem extends StatelessWidget {
  final double nota;
  final String imageUrl;
  final bool isFavorito;
  final String title;

  const ComponentesDaImagem({
    required this.nota,
    required this.imageUrl,
    required this.isFavorito,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Image(
                      image: Image.network(imageUrl).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    //Localização da nota na imagem.
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
              Positioned(
                top: 0,
                right: 0,
                child: FavoritarManga(
                  isFavorito: isFavorito,
                  onPressed: () {},
                ),
              ),
              Positioned(
                bottom: 24,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 45,
                    height: 25,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0XFF98C129),
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
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
