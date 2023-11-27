import 'package:flutter/material.dart';
import 'package:mangafaver/screens/AdicionarMangaScreen.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/screens/MangaScreen.dart';
import 'package:mangafaver/screens/loginScreen.dart';
import 'package:mangafaver/screens/registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import './providers/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
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
