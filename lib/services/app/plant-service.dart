import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/app/plant/res-plant-model.dart';
import 'package:starlightserviceapp/models/app/plant/plant-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';

class PlantService {
  Future<List<PlantModel>> getAll(BuildContext context) async {
    print("getPlantAll");
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(URL_API_APP, "$VERSION_API_APP/msplant");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await get(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return getAll(context);
        } else {
          throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResPlantModel data = ResPlantModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data;
          } else {
            throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return getAll(context);
          } else {
            throw ("Token Expired");
          }
        } else {
          throw (data.message);
        }
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
    } catch (e) {
      log("$e", name: "catch data");
      throw ("$e");
    }
  }
}
