import 'package:flutter/material.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBar2 extends StatefulWidget implements PreferredSizeWidget {
  const AppBar2({Key? key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  _AppBar2State createState() => _AppBar2State();
}

class _AppBar2State extends State<AppBar2> {
  late bool? isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getString('token') != null;
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('isAdmin');

    // Atualiza o estado para refletir a mudança no status de login
    setState(() {
      isLoggedIn = false;
    });

    // Recarrega a tela
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(searchTerm: "")),
    );
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

    void onSearchSubmitted(String value) {
      final String searchTerm = searchController.text;
      navigateToSearch(context, searchTerm);
    }

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
          // Título da AppBar.
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
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE67D0B),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            // Barra de Pesquisa.
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
          const Spacer(),
          InkWell(
            onTap: () {
              if (isLoggedIn != null && isLoggedIn!) {
                // Se estiver logado, faça logout
                logout();
              } else {
                // Se não estiver logado, vá para a tela de login
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
                  child: Icon(
                    isLoggedIn != null && isLoggedIn!
                        ? Icons.exit_to_app // ícone de logout
                        : Icons.person_outlined, // ícone de entrar
                    color: const Color(0XFFE67D0B),
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    isLoggedIn != null && isLoggedIn! ? 'Sair' : 'Entrar',
                    style: const TextStyle(
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
      // Linha branca abaixo da AppBar.
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