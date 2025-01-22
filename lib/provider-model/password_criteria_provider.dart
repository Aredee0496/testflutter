import 'package:flutter/material.dart';

class PasswordCriteriaProvider with ChangeNotifier {
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;

  String newPassword = '';
  String confirmPassword = '';

  bool get passwordsMatch => newPassword == confirmPassword;

  bool get isPasswordValid =>
      hasUppercase &&
      hasLowercase &&
      hasNumber &&
      hasSpecialChar &&
      hasMinLength &&
      passwordsMatch;

  void validatePassword(String password) {
    newPassword = password;
    hasUppercase = password.contains(RegExp(r'[A-Z]'));
    hasLowercase = password.contains(RegExp(r'[a-z]'));
    hasNumber = password.contains(RegExp(r'[0-9]'));
    hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_/-]'));
    hasMinLength = password.length >= 8;

    notifyListeners();
  }

  void validateConfirmPassword(String password) {
    confirmPassword = password;
    notifyListeners();
  }

  void resetCriteria() {
    hasMinLength = false;
    hasUppercase = false;
    hasLowercase = false;
    hasNumber = false;
    hasSpecialChar = false;
    notifyListeners();
  }
}
