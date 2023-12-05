import 'package:flutter/material.dart';

class BotoesHomeScreen extends StatelessWidget {
  final Color buttonColor;
  final Color filterColor;
  final double topPadding;
  final double rightPadding;
  final double spaceBetweenItems;
  final VoidCallback onPressedMaisPopulares;

  const BotoesHomeScreen({
    Key? key,
    this.buttonColor = const Color(0XFFFF9900),
    this.filterColor = const Color(0XFFFF9900),
    //Distância do topo e do lado direito quando a tela está grande.
    this.topPadding = 20,
    this.rightPadding = 55,
    this.spaceBetweenItems = 5,
    required this.onPressedMaisPopulares, required String searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    double adjustedTopPadding = topPadding;
    double adjustedRightPadding = rightPadding;

    //Distância do topo e do lado direito quando a tela está pequena.
    if (screenSize.width <= 600) {
      adjustedTopPadding = 20;
      adjustedRightPadding = 140;
    }

    return Padding(
      padding:
          EdgeInsets.only(top: adjustedTopPadding, right: adjustedRightPadding),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Botão "Mais Populares".
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: onPressedMaisPopulares,
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: buttonColor,
                    ),
                    SizedBox(width: spaceBetweenItems),
                    Text(
                      'Mais Populares',
                      style: TextStyle(color: buttonColor),
                    ),
                  ],
                ),
              ),
            ),
            //Espaço entre os botões.
            const SizedBox(width: 16),
            //Botão "Filtros".
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: filterColor,
                    ),
                    SizedBox(width: spaceBetweenItems),
                    Text(
                      'Filtros',
                      style: TextStyle(color: filterColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
