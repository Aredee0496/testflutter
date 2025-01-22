import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/app/file/res-attachment-model.dart';
import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-model.dart';
import 'package:starlightserviceapp/models/app/jobmoving/res-jobmoving-model.dart';
import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';
import 'package:starlightserviceapp/models/app/jobstatus/res-jobstatus-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/masterdata-tank-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/res-masterdata-tank-model.dart';
import 'package:starlightserviceapp/models/app/res-check-stastus-model.dart';
import 'package:starlightserviceapp/models/app/tank-driver/res-tank-details-model.dart';
import 'package:starlightserviceapp/models/app/tank-driver/res-tank-search-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';

class TankService {
  Future<List<JobStatusModel>> getJobStatus(BuildContext context) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final params = {
        'JobStatusCode': '2,9,3,8',
      };
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/msjobstatus", params);
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await get(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return getJobStatus(context);
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
            return getJobStatus(context);
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

  Future<List<TrTankManagementsRow>> search(
      BuildContext context, Object data) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trtankmanagementmbdriver/search");
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
        ResTankSearchModel data =
            ResTankSearchModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data.trTankManagements.rows;
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

  Future<List<JobMovingModel>> getAll(BuildContext context) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(URL_API_APP, "$VERSION_API_APP/trjobmoving");
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
        ResJobMovingModel data =
            ResJobMovingModel.fromJson(jsonDecode(response.body));
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

  Future<TankDetailsDataModel> getById(BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trtankmanagementmbdriver/$id");
      final headers = {
        "Content-Type": "application/json",
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
        ResTankDetailsModel data =
            ResTankDetailsModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data;
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
      log("$e", name: "catch data");
      return throw ("$e");
    }
  }

  Future<MasterDataTankModel> getMasterData(BuildContext context) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(URL_API_APP,
          "$VERSION_API_APP/trtankmanagementmbdriver/getdatamaster");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await get(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return getMasterData(context);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        ResMasterDataTankModel data =
            ResMasterDataTankModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            return data.data;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return getMasterData(context);
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

  Future<ResCheckStatusModel> update(
      BuildContext context, String id, String body) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trtankmanagementmbdriver/$id");
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

  Future<ResCheckStatusModel> insert(BuildContext context, String body) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/trtankmanagementmbdriver/");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await post(url, headers: headers, body: body);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return insert(context, body);
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
            return insert(context, body);
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

  Future<ResCheckStatusModel> deleteById(
      BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url = Uri.https(
          URL_API_APP, "$VERSION_API_APP/trtankmanagementmbdriver/$id");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await delete(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return deleteById(context, id);
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
            return deleteById(context, id);
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

  Future<ResponseModel> attatchment(BuildContext context, String body) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/trjobmoving/attatchment/");
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
      log("$e", name: "catch data");
      return throw ("$e");
    }
  }

  Future<ResAttachmentModel> download(BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/trjobmoving/download/$id");
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
      log("$e", name: "catch data");
      return throw ("$e");
    }
  }

  Future<ResponseModel> deleteAttachment(
      BuildContext context, String id) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      String token = await storageApp.getAccessToken();
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/trjobmoving/delbyfile/$id");
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
      log("$e", name: "catch data");
      return throw ("$e");
    }
  }
}
