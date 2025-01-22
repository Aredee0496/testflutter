// To parse this JSON data, do
//
//     final getByCodeModel = getByCodeModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/rack/rack-model.dart';

GetByCodeModel getByCodeModelFromJson(String str) =>
    GetByCodeModel.fromJson(json.decode(str));

String getByCodeModelToJson(GetByCodeModel data) => json.encode(data.toJson());

class GetByCodeModel {
  int code;
  String result;
  String message;
  Data data;

  GetByCodeModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory GetByCodeModel.fromJson(Map<String, dynamic> json) => GetByCodeModel(
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
  List<RackModel> rows;

  Data({
    required this.count,
    required this.rows,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        rows: List<RackModel>.from(
            json["rows"].map((x) => RackModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}
