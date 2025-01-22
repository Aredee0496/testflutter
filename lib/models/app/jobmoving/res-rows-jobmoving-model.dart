// To parse this JSON data, do
//
//     final resRowsJobMovingModel = resRowsJobMovingModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-model.dart';

ResRowsJobMovingModel resRowsJobMovingModelFromJson(String str) =>
    ResRowsJobMovingModel.fromJson(json.decode(str));

String resRowsJobMovingModelToJson(ResRowsJobMovingModel data) =>
    json.encode(data.toJson());

class ResRowsJobMovingModel {
  int code;
  String result;
  String message;
  Data data;

  ResRowsJobMovingModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResRowsJobMovingModel.fromJson(Map<String, dynamic> json) =>
      ResRowsJobMovingModel(
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
  List<JobMovingModel> rows;

  Data({
    required this.count,
    required this.rows,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        rows: List<JobMovingModel>.from(
            json["rows"].map((x) => JobMovingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<JobMovingModel>.from(rows.map((x) => x)),
      };
}
