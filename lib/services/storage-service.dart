import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/family/auth-model.dart';
import 'package:starlightserviceapp/models/family/menu-model.dart';

class StorageApp {
  String appname = "wmx-wip";
  String formatDatetime = "yyyy-MM-dd HH:mm:sss";

  setExpired() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    DateTime now = DateTime.now();
    final temp = now.add(const Duration(hours: 8));
    String formattedDate = DateFormat(formatDatetime).format(temp);
    print("formattedDate: $formattedDate");
    prefs.setString("expired-$appname", formattedDate);
  }

  getExpired() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    String expiredDate = prefs.getString("expired-$appname") ?? "";
    print("expiredDate: $expiredDate");
    if (expiredDate != "") {
      DateTime temp = DateFormat(formatDatetime).parse(expiredDate);
      DateTime now = DateTime.now();
      if (now.isAfter(temp)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<void> setAuth(bool value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.setBool("auth-$appname", value);
    setExpired();
  }

  getAuth() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    bool result = prefs.getBool("auth-$appname") ?? false;
    bool expired = await getExpired();
    print("result: $result  expired: $expired");
    return result && expired;
  }

  getAuthenticated() async {
    final accesstoken = await getAccessToken();
    final refreshtoken = await getRefreshToken();
    final authTime = await getAuth();
    if (accesstoken != "" && refreshtoken != "" && authTime) {
      return true;
    }
    return false;
  }

  setAccessToken(String value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    await prefs.setString("accesstoken-$appname", value);
  }

  getAccessToken() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    String? result = prefs.getString("accesstoken-$appname");
    print("getAccessToken $result");
    return result ?? "";
  }

  setRefreshToken(String value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.setString("refreshtoken-$appname", value);
  }

  getRefreshToken() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    final result = prefs.getString("refreshtoken-$appname") ?? "";
    return result;
  }

  setUser(User value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.setString("user-$appname", jsonEncode(value));
  }

  getUser() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    final result = prefs.getString("user-$appname") ?? "";
    if (result != "") {
      final temp = jsonDecode(result);
      return User.fromJson(temp);
    }
    return null;
  }

  setRole(Role value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.setString("role-$appname", jsonEncode(value));
  }

  getRole() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    final result = prefs.getString("role-$appname") ?? "";

    if (result != "") {
      final temp = jsonDecode(result);
      return Role.fromJson(temp);
    }
    return null;
  }

  setMenu(DataMenu value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.setString("menu-$appname", jsonEncode(value));
  }

  getMenu() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    final result = prefs.getString("menu-$appname") ?? "";
    print(result);
    if (result != "") {
      final temp = jsonDecode(result);
      print(temp);
      return DataMenu.fromJson(temp);
    }
    return null;
  }

  setPlant(String value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.setString("plant-$appname", value);
  }

  getPlant() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    String result = prefs.getString("plant-$appname") ?? "";
    return result;
  }

  setIdApp(String value) async {
    print("setIdApp: $value");
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    await prefs.setString("idapp-$appname", value);
  }

  getIdApp() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    String? result = prefs.getString("idapp-$appname");
    print("getIdApp: $result");
    return result ?? "";
  }

  setProfile(MsEmployee value) async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.setString("profile-$appname", jsonEncode(value));
  }

  getProfile() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    final result = prefs.getString("profile-$appname") ?? "";
    if (result != "") {
      final temp = jsonDecode(result);
      return MsEmployee.fromJson(temp);
    }
    return null;
  }

  clearRole() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    prefs.remove("role-$appname");
  }

  clearAll() async {
    await EncryptedSharedPreferences.initialize(KEYSTORAGE);
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();
    setAuth(false);
    prefs.clear();
  }
}
