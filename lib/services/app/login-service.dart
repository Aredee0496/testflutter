import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:starlightserviceapp/encrypt.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/models/family/getdata-model.dart';
import 'package:starlightserviceapp/models/family/login-model.dart';

class LoginService {
  Future<GetIdModelData> getData(BuildContext context) async {
    StorageApp _storageApp = StorageApp();

    try {
      final storedId = await _storageApp.getIdApp();
      final body = {
        "Id": "$storedId",
      };

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      const urlApiApp = 'devapistlconnect.sritranggroup.com';
      const versionApiApp = 'v2';

      final url = Uri.https(urlApiApp, '$versionApiApp/sylogin/validateid');
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        GetIdModel data = GetIdModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data;
          } else {
            return throw (data.message);
          }
        } else {
          return throw (data.message);
        }
      } else {
        GetIdModel data = GetIdModel.fromJson(jsonDecode(response.body));
        return throw (data.message);
      }
    } catch (e) {
      return throw ("$e");
    }
  }

  Future<LoginModel> Login(BuildContext context, String userid, String password,
      String appname, String token) async {
    try {
      final useridtemp = await EncryptData().encrypt(userid);
      final passwordtemp = await EncryptData().encrypt(password);

      final headers = {
        'Content-Type': 'application/json',
        'accesstoken': token,
      };
      final body = {
        "appname": appname,
        "userid": useridtemp,
        "password": passwordtemp
      };
      const urlApiApp = 'devapistlconnect.sritranggroup.com';
      const versionApiApp = 'v2';

      final url = Uri.https(urlApiApp, '$versionApiApp/sylogin/login');
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        LoginModel data = LoginModel.fromJson(jsonDecode(response.body));
        return data;
      } else {
        ResponseModel data = ResponseModel.fromJson(jsonDecode(response.body));
        return throw (data.message);
      }
    } catch (e) {
      return throw ("$e");
    }
  }
}
