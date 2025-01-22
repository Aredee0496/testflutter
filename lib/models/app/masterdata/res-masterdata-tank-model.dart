// To parse this JSON data, do
//
//     final masterDataModel = masterDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/masterdata/masterdata-tank-model.dart';

ResMasterDataTankModel masterDataModelFromJson(String str) =>
    ResMasterDataTankModel.fromJson(json.decode(str));

class ResMasterDataTankModel {
  int code;
  String result;
  String message;
  MasterDataTankModel data;

  ResMasterDataTankModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResMasterDataTankModel.fromJson(Map<String, dynamic> json) =>
      ResMasterDataTankModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: MasterDataTankModel.fromJson(json["data"]),
      );
}
