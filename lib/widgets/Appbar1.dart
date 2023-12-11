import 'package:flutter/material.dart';
import 'package:mangafaver/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mangafaver/screens/HomeScreen.dart';

class AppBar1 extends StatefulWidget {
  const AppBar1({Key? key}) : super(key: key);

  @override
  _AppBar1State createState() => _AppBar1State();
}

class _AppBar1State extends State<AppBar1> {
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.containsKey('token');
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // Adicione qualquer lógica adicional que você precisa ao fazer logout

    // Atualiza o estado para refletir a mudança no status de login
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(
                    searchTerm: ''), // Se necessário, passe um searchTerm aqui
              ),
            );
          },
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                          searchTerm:
                              ''), // Se necessário, passe um searchTerm aqui
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/icon.png',
                  width: 40,
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                          searchTerm:
                              ''), // Se necessário, passe um searchTerm aqui
                    ),
                  );
                },
                child: const Text(
                  'Manga\nFever',
                  style: TextStyle(fontFamily: 'KronaOne-Regular'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        isLoggedIn
            ? IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Color(0xFFE6810B),
                  size: 40,
                ),
                onPressed: () {
                  logout();
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.person_outlined,
                  color: Color(0xFFE6810B),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
              ),
      ],
    );
  }
}
