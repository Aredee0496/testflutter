// To parse this JSON data, do
//
//     final resAttachmentModel = resAttachmentModelFromJson(jsonString);

import 'dart:convert';

ResAttachmentNoDataModel resAttachmentModelFromJson(String str) =>
    ResAttachmentNoDataModel.fromJson(json.decode(str));

String resAttachmentModelToJson(ResAttachmentNoDataModel data) =>
    json.encode(data.toJson());

class ResAttachmentNoDataModel {
  int code;
  String result;
  String message;

  ResAttachmentNoDataModel({
    required this.code,
    required this.result,
    required this.message,
  });

  factory ResAttachmentNoDataModel.fromJson(Map<String, dynamic> json) =>
      ResAttachmentNoDataModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() =>
      {"code": code, "result": result, "message": message};
}
