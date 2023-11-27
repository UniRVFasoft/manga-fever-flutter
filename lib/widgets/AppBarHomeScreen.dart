import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mangafaver/providers/user_provider.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/screens/loginScreen.dart';
import 'package:provider/provider.dart';

class AppBarHomeScreen extends StatelessWidget implements PreferredSizeWidget {
  AppBarHomeScreen({Key? key, this.showSearchBar = true}) : super(key: key);

  final bool showSearchBar;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  final TextEditingController searchController = TextEditingController();

  void onSearchSubmitted(String value) {
    final String searchTerm = searchController.text;
    navigateToSearch(context as BuildContext, searchTerm);
  }

  void navigateToSearch(BuildContext context, String searchTerm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(searchTerm: searchTerm),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final userProvider = Provider.of<UserProvider>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF242424),
      elevation: 0,
      centerTitle: true,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              navigateToSearch(context, '');
            },
            child: Image.asset(
              'assets/images/icon.png',
              height: AppBar().preferredSize.height * 1.1,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'MANGA',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontFamily: 'KronaOne-Regular',
                ),
              ),
              Text(
                'FEVER',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontFamily: 'KronaOne-Regular',
                ),
              ),
            ],
          ),
          if (showSearchBar) ...[
            const Spacer(),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    // Tamanho da barra de pesquisa em telas maiores.
                    width: MediaQuery.of(context).size.width > 600 ? 420 : 180,
                    height: 28,
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Pesquisar...',
                        hintStyle: TextStyle(
                          color: const Color(0xFF878787).withOpacity(0.5),
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.5,
                          horizontal: 10,
                        ),
                      ),
                      onSubmitted: onSearchSubmitted,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      final String searchTerm = searchController.text;
                      navigateToSearch(context, searchTerm);
                    },
                    child: const Icon(
                      Icons.search,
                      color: Color(0XFFE67D0B),
                    ),
                  )
                ],
              ),
            ),
          ],
          const Spacer(),
          InkWell(
            onTap: () {
              if (userProvider.isLoggedIn) {
                // Handle logout
                userProvider.logout();
              } else {
                // Handle login
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            },
            child: Column(
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color(0XFFE67D0B),
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/icone-user.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    userProvider.isLoggedIn ? userProvider.userName : 'Entrar',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0XFFE67D0B),
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 1,
          color: Colors.white,
        ),
      ),
    );
  }
}
