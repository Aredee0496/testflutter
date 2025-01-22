import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/app/transportclearing/res-transportclearing-getbyid-model.dart';
import 'package:starlightserviceapp/models/app/transportclearing/res-transportclearing-search-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';

class TransportClearingService {
  Future<List<TrTransportClearingSearchRow>> search(
      BuildContext context, Object data) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trtransportclearingdriver/search/");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      };
      final response =
          await post(url, headers: headers, body: jsonEncode(data));
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return search(context, data);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        TrTransportClearingSearchModel data =
            TrTransportClearingSearchModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data.rows;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return search(context, data);
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
      return throw ("$e");
    }
  }

  Future<ResTransportClearingGetByIdModel> getById(
      BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trtransportclearingdriver/$id");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      };
      final response = await get(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return getById(context, id);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResTransportClearingGetByIdModel data =
            ResTransportClearingGetByIdModel.fromJson(
                jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return getById(context, id);
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
      return throw ("$e");
    }
  }
}
