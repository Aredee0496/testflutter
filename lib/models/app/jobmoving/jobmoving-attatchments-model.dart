// To parse this JSON data, do
//
//     final trJobMovingAttatchmentsModel = trJobMovingAttatchmentsModelFromJson(jsonString);

import 'dart:convert';

TrJobMovingAttatchmentsModel trJobMovingAttatchmentsModelFromJson(String str) =>
    TrJobMovingAttatchmentsModel.fromJson(json.decode(str));

String trJobMovingAttatchmentsModelToJson(TrJobMovingAttatchmentsModel data) =>
    json.encode(data.toJson());

class TrJobMovingAttatchmentsModel {
  String? jobMovingAttatmentId;
  String? attatment;
  String? fullFilePath;
  String? fileId;

  TrJobMovingAttatchmentsModel({
    this.jobMovingAttatmentId,
    this.attatment,
    this.fullFilePath,
    this.fileId,
  });

  factory TrJobMovingAttatchmentsModel.fromJson(Map<String, dynamic> json) =>
      TrJobMovingAttatchmentsModel(
        jobMovingAttatmentId: json["JobMovingAttatmentID"],
        attatment: json["Attatment"],
        fullFilePath: json["FullFilePath"],
        fileId: json["FileID"],
      );

  Map<String, dynamic> toJson() => {
        "JobMovingAttatmentID": jobMovingAttatmentId,
        "Attatment": attatment,
        "FullFilePath": fullFilePath,
        "FileID": fileId,
      };
}
