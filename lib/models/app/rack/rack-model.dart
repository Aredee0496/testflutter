// To parse this JSON data, do
//
//     final rackModel = rackModelFromJson(jsonString);

import 'dart:convert';

RackModel rackModelFromJson(String str) => RackModel.fromJson(json.decode(str));

String rackModelToJson(RackModel data) => json.encode(data.toJson());

class RackModel {
  String rackId;
  String? plantCode;
  String? plantName;
  String? rackCode;
  String? subPlantCode;
  String? subPlantName;
  int? floorId;
  String? colorCode;
  String? colorName;
  int? side;
  String? sideDescription;
  int? status;
  int? rackStatus;
  String? topReserveBy;
  String? bottomReserveBy;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  RackModel({
    required this.rackId,
    this.plantCode,
    this.plantName,
    this.rackCode,
    this.subPlantCode,
    this.subPlantName,
    this.floorId,
    this.colorCode,
    this.colorName,
    this.side,
    this.sideDescription,
    this.status,
    this.rackStatus,
    this.topReserveBy,
    this.bottomReserveBy,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory RackModel.fromJson(Map<String, dynamic> json) => RackModel(
        rackId: json["RackID"],
        plantCode: json["PlantCode"],
        plantName: json["PlantName"],
        rackCode: json["RackCode"],
        subPlantCode: json["SubPlantCode"],
        subPlantName: json["SubPlantName"],
        floorId: json["FloorID"],
        colorCode: json["ColorCode"],
        colorName: json["ColorName"],
        side: json["Side"],
        sideDescription: json["SideDescription"],
        status: json["Status"],
        rackStatus: json["RackStatus"],
        topReserveBy: json["TopReserveBy"],
        bottomReserveBy: json["BottomReserveBy"],
        createdBy: json["CreatedBy"],
        createdAt: json["CreatedAt"],
        updatedBy: json["UpdatedBy"],
        updatedAt: json["UpdatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "RackID": rackId,
        "PlantCode": plantCode,
        "PlantName": plantName,
        "RackCode": rackCode,
        "SubPlantCode": subPlantCode,
        "SubPlantName": subPlantName,
        "FloorID": floorId,
        "ColorCode": colorCode,
        "ColorName": colorName,
        "Side": side,
        "SideDescription": sideDescription,
        "Status": status,
        "RackStatus": rackStatus,
        "TopReserveBy": topReserveBy,
        "BottomReserveBy": bottomReserveBy,
        "CreatedBy": createdBy,
        "CreatedAt": createdAt,
        "UpdatedBy": updatedBy,
        "UpdatedAt": updatedAt,
      };
}
