// To parse this JSON data, do
//
//     final resAttachmentModel = resAttachmentModelFromJson(jsonString);

import 'dart:convert';

ResCheckStatusModel resAttachmentModelFromJson(String str) =>
    ResCheckStatusModel.fromJson(json.decode(str));

String resAttachmentModelToJson(ResCheckStatusModel data) =>
    json.encode(data.toJson());

class ResCheckStatusModel {
  int code;
  String result;
  String message;

  ResCheckStatusModel({
    required this.code,
    required this.result,
    required this.message,
  });

  factory ResCheckStatusModel.fromJson(Map<String, dynamic> json) =>
      ResCheckStatusModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() =>
      {"code": code, "result": result, "message": message};
}
