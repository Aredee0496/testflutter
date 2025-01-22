import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/app/file/res-attachment-model.dart';
import 'package:starlightserviceapp/models/app/file/res-attachment-nodata-model.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/worklist/res-rows-worklist-model.dart';
import 'package:starlightserviceapp/models/app/worklist/worklist-details-model.dart';
import 'package:starlightserviceapp/models/app/worklist/worklist-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';

class WorklistService {
  Future<List<WorklistModel>> search(BuildContext context, Object data) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/trworklistdriver/search/");
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
        ResRowsWorklistModel data =
            ResRowsWorklistModel.fromJson(jsonDecode(response.body));
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

  Future<WorklistDetailsModel> getById(BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/trworklistdriver/$id");
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
        WorklistDetailsModel data =
            WorklistDetailsModel.fromJson(jsonDecode(response.body));
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

  Future<ResCheckStatusModel> update(
      BuildContext context, String id, String body) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/trworklistdriver/$id");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await put(url, headers: headers, body: body);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return update(context, id, body);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResCheckStatusModel data =
            ResCheckStatusModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return update(context, id, body);
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
          ResCheckStatusModel data =
              ResCheckStatusModel.fromJson(jsonDecode(response.body));
          return throw (data.message);
        }
      }
    } catch (e) {
      return throw ("$e");
    }
  }

  Future<ResCheckStatusModel> updatestatus9(
      BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trworklistdriver/updatestatus9/$id");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await put(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return updatestatus9(context, id);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResCheckStatusModel data =
            ResCheckStatusModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return updatestatus9(context, id);
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
          ResCheckStatusModel data =
              ResCheckStatusModel.fromJson(jsonDecode(response.body));
          return throw (data.message);
        }
      }
    } catch (e) {
      return throw ("$e");
    }
  }

  Future<ResAttachmentNoDataModel> attatchment(
      BuildContext context, String body) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trworklistdriver/attatchment");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await post(url, headers: headers, body: body);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return attatchment(context, body);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResAttachmentNoDataModel data =
            ResAttachmentNoDataModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return attatchment(context, body);
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

  Future<ResAttachmentModel> download(BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trworklistdriver/download/$id");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await get(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return download(context, id);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResAttachmentModel data =
            ResAttachmentModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return download(context, id);
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

  Future<ResponseModel> deleteAttachment(
      BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trworklistdriver/delbyfile/$id");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await delete(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return deleteAttachment(context, id);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResponseModel data = ResponseModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return deleteAttachment(context, id);
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
