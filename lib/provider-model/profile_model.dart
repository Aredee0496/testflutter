import 'dart:convert';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:starlightserviceapp/config/env.dart';
import '../models/family/auth-model.dart';

class ProfileModel2 extends ChangeNotifier {
  List<MsEmployee> _profile = [];
  Uint8List? _profileImage;

  List<MsEmployee> get profile => _profile;
  Uint8List? get profileImage => _profileImage;

  Future<void> setProfile(List<MsEmployee> profile) async {
    _profile = profile;
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    String jsonString = jsonEncode(_profile.map((e) => e.toJson()).toList());
    await prefs.setString('profile', jsonString);
    notifyListeners();
  }

  Future<void> setProfileImage(Uint8List imageBytes) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    await prefs.setString('profile_image', base64Image);
    _profileImage = imageBytes;
    notifyListeners();
  }

  Future<void> loadFromSharedPreferences() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();

    String? jsonString = prefs.getString('profile');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      _profile = jsonList.map((e) => MsEmployee.fromJson(e)).toList();
    }

    String? base64Image = prefs.getString('profile_image');
    if (base64Image != null) {
      _profileImage = base64Decode(base64Image);
    }
    notifyListeners();
  }
}
