// To parse this JSON data, do
//
//     final genarateAccessTokenModel = genarateAccessTokenModelFromJson(jsonString);

import 'dart:convert';

GenarateAccessTokenModel genarateAccessTokenModelFromJson(String str) =>
    GenarateAccessTokenModel.fromJson(json.decode(str));

String genarateAccessTokenModelToJson(GenarateAccessTokenModel data) =>
    json.encode(data.toJson());

class GenarateAccessTokenModel {
  int code;
  String result;
  String message;
  Data data;

  GenarateAccessTokenModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory GenarateAccessTokenModel.fromJson(Map<String, dynamic> json) =>
      GenarateAccessTokenModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String token;

  Data({
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
