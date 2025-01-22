// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  int code;
  String result;
  String message;

  ResponseModel({
    required this.code,
    required this.result,
    required this.message,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        code: json["code"] is String ? int.parse(json["code"]) : json["code"],
        result: json["result"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
      };
}
