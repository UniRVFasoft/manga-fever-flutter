import 'package:flutter/material.dart';

class BotoesHomeScreen extends StatefulWidget {
  final Color buttonColor;
  final Color filterColor;
  final double topPadding;
  final double rightPadding;
  final double spaceBetweenItems;
  final VoidCallback onPressedMaisPopulares;
  final VoidCallback handleAlphabeticalOrder;
  final String searchTerm;
  final VoidCallback handleFavoritesFilter; 

  const BotoesHomeScreen({
    Key? key,
    this.buttonColor = const Color(0XFFFF9900),
    this.filterColor = const Color(0XFFFF9900),
    this.topPadding = 20,
    this.rightPadding = 55,
    this.spaceBetweenItems = 5,
    required this.onPressedMaisPopulares,
    required this.handleAlphabeticalOrder,
    required this.searchTerm,
    required this.handleFavoritesFilter,
  }) : super(key: key);

  @override
  _BotoesHomeScreenState createState() => _BotoesHomeScreenState();
}

class _BotoesHomeScreenState extends State<BotoesHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    double adjustedTopPadding = widget.topPadding;
    double adjustedRightPadding = widget.rightPadding;
    double adjustedPosition = screenSize.width <= 600 ? 282 : 1355;

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
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: widget.onPressedMaisPopulares,
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: widget.buttonColor,
                    ),
                    SizedBox(width: widget.spaceBetweenItems),
                    Text(
                      'Mais Populares',
                      style: TextStyle(color: widget.buttonColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                final RenderBox button =
                    context.findRenderObject() as RenderBox;
                final Offset buttonPosition = button.localToGlobal(Offset.zero);
                final Size buttonSize = button.size;

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    buttonPosition.dx + adjustedPosition,
                    buttonPosition.dy + buttonSize.height + 3,
                    buttonPosition.dx + buttonSize.width + adjustedPosition,
                    buttonPosition.dy + buttonSize.height + 60,
                  ),
                  items: [
                    const PopupMenuItem<String>(
                      value: 'favoritos',
                      child: Text(
                        'Favoritos',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'ordem_alfabetica',
                      child: Text(
                        'Ordem Alfabética',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromARGB(255, 57, 56, 56),
                ).then((value) {
                  if (value == 'favoritos') {
                    widget.handleFavoritesFilter();
                  } else if (value == 'ordem_alfabetica') {
                    widget.handleAlphabeticalOrder();
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: widget.filterColor,
                    ),
                    SizedBox(width: widget.spaceBetweenItems),
                    Text(
                      'Filtros',
                      style: TextStyle(color: widget.filterColor),
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
