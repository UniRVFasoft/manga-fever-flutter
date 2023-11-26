import 'package:flutter/material.dart';
import 'package:mangafaver/screens/AdicionarMangaScreen.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/screens/MangaScreen.dart';
import 'package:mangafaver/screens/loginScreen.dart';
import 'package:mangafaver/screens/registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(
          searchTerm: '',
        ),
      ),
    );
  }
}
