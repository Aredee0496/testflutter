// To parse this JSON data, do
//
//     final resRowsWorklistModel = resRowsWorklistModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/worklist/worklist-model.dart';

ResRowsWorklistModel resRowsWorklistModelFromJson(String str) =>
    ResRowsWorklistModel.fromJson(json.decode(str));

String resRowsWorklistModelToJson(ResRowsWorklistModel data) =>
    json.encode(data.toJson());

class ResRowsWorklistModel {
  int code;
  String result;
  String message;
  Data data;

  ResRowsWorklistModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResRowsWorklistModel.fromJson(Map<String, dynamic> json) =>
      ResRowsWorklistModel(
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
  int count;
  List<WorklistModel> rows;

  Data({
    required this.count,
    required this.rows,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        rows: List<WorklistModel>.from(
            json["rows"].map((x) => WorklistModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<WorklistModel>.from(rows.map((x) => x)),
      };
}
