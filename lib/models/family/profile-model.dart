import 'package:flutter/material.dart';

class ProfileModel with ChangeNotifier {
  String _userLogin = "";
  String get userLogin => _userLogin;

  void addprofile(String name) {
    _userLogin = name;
    notifyListeners();
  }
}
