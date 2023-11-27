// user_provider.dart
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = ''; // Add this line for storing the user's name

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;

  void login(String userName) {
    _isLoggedIn = true;
    _userName = userName;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = '';
    notifyListeners();
  }
}
