// To parse this JSON data, do
//
//     final idModel = idModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/family/auth-model.dart';

IdModel idModelFromJson(String str) => IdModel.fromJson(json.decode(str));

String idModelToJson(IdModel data) => json.encode(data.toJson());

class IdModel {
  int code;
  String result;
  String message;
  DataId data;

  IdModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory IdModel.fromJson(Map<String, dynamic> json) => IdModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: DataId.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class DataId {
  String? id;
  String? urloAuth;
  String? urlapiFamily;
  String? accessToken;
  String? token;
  String? pageReDirect;
  Data? dataSTAOAuth;

  DataId({
    this.id,
    this.urloAuth,
    this.urlapiFamily,
    this.accessToken,
    this.token,
    this.pageReDirect,
    this.dataSTAOAuth,
  });

  factory DataId.fromJson(Map<String, dynamic> json) => DataId(
      id: json["Id"],
      urloAuth: json["URLOAuth"],
      urlapiFamily: json["URLAPIFamily"],
      accessToken: json["accessToken"],
      token: json["token"],
      pageReDirect: json["PageReDirect"],
      dataSTAOAuth: json["dataSTAOAuth"] == null
          ? null
          : Data.fromJson(json["dataSTAOAuth"]));

  Map<String, dynamic> toJson() => {
        "Id": id,
        "URLOAuth": urloAuth,
        "URLAPIFamily": urlapiFamily,
        "accessToken": accessToken,
        "token": token,
      };
}
