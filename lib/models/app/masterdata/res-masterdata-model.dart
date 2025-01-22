// To parse this JSON data, do
//
//     final masterDataModel = masterDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/masterdata/masterdata-model.dart';

ResMasterDataModel masterDataModelFromJson(String str) =>
    ResMasterDataModel.fromJson(json.decode(str));

String masterDataModelToJson(ResMasterDataModel data) =>
    json.encode(data.toJson());

class ResMasterDataModel {
  int code;
  String result;
  String message;
  MasterDataModel data;

  ResMasterDataModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResMasterDataModel.fromJson(Map<String, dynamic> json) =>
      ResMasterDataModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: MasterDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}
