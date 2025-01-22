// To parse this JSON data, do
//
//     final resAttachmentModel = resAttachmentModelFromJson(jsonString);

import 'dart:convert';

ResAttachmentModel resAttachmentModelFromJson(String str) =>
    ResAttachmentModel.fromJson(json.decode(str));

String resAttachmentModelToJson(ResAttachmentModel data) =>
    json.encode(data.toJson());

class ResAttachmentModel {
  int code;
  String result;
  String message;
  String data;

  ResAttachmentModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResAttachmentModel.fromJson(Map<String, dynamic> json) =>
      ResAttachmentModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: json["data"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": data,
      };
}
