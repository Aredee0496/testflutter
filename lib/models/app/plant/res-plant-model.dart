// To parse this JSON data, do
//
//     final getPlantModel = getPlantModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/plant/plant-model.dart';

ResPlantModel getPlantModelFromJson(String str) =>
    ResPlantModel.fromJson(json.decode(str));

String getPlantModelToJson(ResPlantModel data) => json.encode(data.toJson());

class ResPlantModel {
  int code;
  String result;
  String message;
  List<PlantModel> data;

  ResPlantModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResPlantModel.fromJson(Map<String, dynamic> json) => ResPlantModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: List<PlantModel>.from(
            json["data"].map((x) => PlantModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": List<PlantModel>.from(data.map((x) => x.toJson())),
      };
}
