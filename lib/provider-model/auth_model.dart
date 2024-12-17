import 'package:flutter/foundation.dart';

class AuthModel extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;  

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  void setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void setRefreshToken(String token) {
    _refreshToken = token;
    notifyListeners();
  }

}
