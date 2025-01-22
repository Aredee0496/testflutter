// To parse this JSON data, do
//
//     final plantModel = plantModelFromJson(jsonString);

import 'dart:convert';

PlantModel plantModelFromJson(String str) =>
    PlantModel.fromJson(json.decode(str));

String plantModelToJson(PlantModel data) => json.encode(data.toJson());

class PlantModel {
  String plantCode;
  String plantName;
  int status;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  PlantModel({
    required this.plantCode,
    required this.plantName,
    required this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) => PlantModel(
        plantCode: json["PlantCode"],
        plantName: json["PlantName"],
        status: json["Status"],
        createdBy: json["CreatedBy"],
        createdAt: json["CreatedAt"],
        updatedBy: json["UpdatedBy"],
        updatedAt: json["UpdatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "PlantCode": plantCode,
        "PlantName": plantName,
        "Status": status,
        "CreatedBy": createdBy,
        "CreatedAt": createdAt,
        "UpdatedBy": updatedBy,
        "UpdatedAt": updatedAt,
      };
}
