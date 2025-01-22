import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';
import 'package:starlightserviceapp/models/app/jobstatus/res-jobstatus-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';

class JobStatusService {
  Future<List<JobStatusModel>> getAll(BuildContext context) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(URL_API_APP, "$VERSION_API_APP/msjobstatus");
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
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResJobStatusModel data =
            ResJobStatusModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return getAll(context);
          } else {
            return throw ("Token Expired");
          }
        } else {
          return throw (data.message);
        }
      } else {
        if (response.statusCode == 503 || response.statusCode == 502) {
          return throw ("${response.statusCode}: ${response.reasonPhrase}");
        } else {
          ResponseModel data =
              ResponseModel.fromJson(jsonDecode(response.body));
          return throw (data.message);
        }
      }
    } catch (e) {
      log("$e", name: "catch data");
      return throw ("$e");
    }
  }

  Future<List<JobStatusModel>> getById(
      BuildContext context, List<String> id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String params = "";
      if (id.length > 0) {
        for (var i = 0; i < id.length; i++) {
          params = params + id[i];
          if (i < id.length - 1) {
            params = "$params,";
          }
        }
      }
      String token = await storageApp.getAccessToken();
      final url = Uri.https(URL_API_APP, "$VERSION_API_APP/msjobstatus$params");
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
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResJobStatusModel data =
            ResJobStatusModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return getAll(context);
          } else {
            return throw ("Token Expired");
          }
        } else {
          return throw (data.message);
        }
      } else {
        if (response.statusCode == 503 || response.statusCode == 502) {
          return throw ("${response.statusCode}: ${response.reasonPhrase}");
        } else {
          ResponseModel data =
              ResponseModel.fromJson(jsonDecode(response.body));
          return throw (data.message);
        }
      }
    } catch (e) {
      log("$e", name: "catch data");
      return throw ("$e");
    }
  }
}
