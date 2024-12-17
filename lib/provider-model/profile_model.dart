import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/provider-model/family/profile-model.dart';

class ProfileModel extends ChangeNotifier {
  List<MsEmployee> _profile = [];
  Uint8List? _profileImage;

  List<MsEmployee> get profile => _profile;
  Uint8List? get profileImage => _profileImage;

  Future<void> setProfile(List<MsEmployee> profile) async {
    _profile = profile;
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(_profile.map((e) => e.toJson()).toList());
    await prefs.setString('profile', jsonString);
    notifyListeners();
  }

   Future<void> setProfileImage(Uint8List imageBytes) async {
     final prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    await prefs.setString('profile_image', base64Image);
    _profileImage = imageBytes;
    notifyListeners();
  }

  Future<void> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
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
