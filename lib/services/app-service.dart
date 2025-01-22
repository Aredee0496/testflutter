import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/family/accesstoken-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/pages/login.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/widgets/dialog-message.dart';

class AppService {
  logout(BuildContext context) {
    StorageApp storageApp = StorageApp();
    storageApp.clearAll();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  checkExpired(int responseStatus) {
    if (responseStatus == 401 || responseStatus == 403) {
      return true;
    } else {
      return false;
    }
  }

  void showDialogLogout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return dialogMessage(
              context, "Session Expired!", "Please login try again");
        }).then((value) async {
      logout(context);
    });
  }

  generateAccessToken(BuildContext context) async {
    StorageApp storageApp = StorageApp();
    String token = await storageApp.getRefreshToken();
    final url = Uri.https(URL_API_APP, "$VERSION_API_APP/token/genaccesstoken");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    final response = await get(url, headers: headers);
    if (checkExpired(response.statusCode)) {
      showDialogLogout(context);
    } else {
      if (response.statusCode == 200) {
        final data =
            GenarateAccessTokenModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            await storageApp.setAccessToken(data.data.token);
            ResponseModel responseModel = ResponseModel(
                code: data.code, result: data.result, message: data.message);
            return responseModel;
          } else {
            throw (data.message);
          }
        } else {
          if (checkExpired(data.code)) {
            showDialogLogout(context);
          }
          throw (data.message);
        }
      } else if (checkExpired(response.statusCode)) {
        showDialogLogout(context);
      } else {
        try {
          ResponseModel data =
              ResponseModel.fromJson(jsonDecode(response.body));
          throw (data.message);
        } catch (e) {
          if (response.statusCode == 503 || response.statusCode == 502) {
            // throw ("503 Service Temporarily Unavailable");
            throw ("${response.statusCode}: ${response.reasonPhrase}");
          } else {
            throw ("$e");
          }
        }
      }
    }
  }
}
