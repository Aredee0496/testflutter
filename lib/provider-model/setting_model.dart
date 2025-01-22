import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel with ChangeNotifier {
  bool _isBiometricEnabled = true;
  bool get isBiometricEnabled => _isBiometricEnabled;

  final LocalAuthentication _localAuth = LocalAuthentication();

  SettingsModel() {
    _loadSettings();
  }

  _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isBiometricEnabled =
        prefs.getBool('isBiometricEnabled') ?? true; 
    notifyListeners();
  }

  _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isBiometricEnabled', _isBiometricEnabled);
  }

  void toggleBiometric(bool value) {
    _isBiometricEnabled = value;
    _saveSettings(); 
    notifyListeners();
  }

  Future<bool> authenticateUser() async {
    try {
      final bool canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
      if (!canAuthenticate) {
        return false;
      }

      return await _localAuth.authenticate(
        localizedReason: 'กรุณาทำการตรวจสอบสิทธิ์ก่อนเข้าใช้งานแอป',
        options: const AuthenticationOptions(
          biometricOnly:
              false,
          stickyAuth:
              true,
        ),
      );
    } catch (e) {
      print('Authentication error: $e');
      return false;
    }
  }
}
