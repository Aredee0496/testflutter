// To parse this JSON data, do
//
//     final resTankSearchModel = resTankSearchModelFromJson(jsonString);

import 'dart:convert';

ResTankSearchModel resTankSearchModelFromJson(String str) =>
    ResTankSearchModel.fromJson(json.decode(str));

class ResTankSearchModel {
  int code;
  String result;
  String message;
  Data data;

  ResTankSearchModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResTankSearchModel.fromJson(Map<String, dynamic> json) =>
      ResTankSearchModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  TrTankManagements trTankManagements;

  Data({
    required this.trTankManagements,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trTankManagements:
            TrTankManagements.fromJson(json["TRTankManagements"]),
      );
}

class TrTankManagements {
  int count;
  List<TrTankManagementsRow> rows;

  TrTankManagements({
    required this.count,
    required this.rows,
  });

  factory TrTankManagements.fromJson(Map<String, dynamic> json) =>
      TrTankManagements(
        count: json["count"],
        rows: List<TrTankManagementsRow>.from(
            json["rows"].map((x) => TrTankManagementsRow.fromJson(x))),
      );
}

class TrTankManagementsRow {
  String? tankManagementId;
  String? plant;
  String? tankManagementNo;
  String? workStatusCode;
  String? workStatus;
  String? workDate;
  String? workTime;
  String? driverName;
  String? tankNo;
  String? tankType;
  String? cleanType;

  TrTankManagementsRow({
    this.tankManagementId,
    this.plant,
    this.tankManagementNo,
    this.workStatusCode,
    this.workStatus,
    this.workDate,
    this.workTime,
    this.driverName,
    this.tankNo,
    this.tankType,
    this.cleanType,
  });

  factory TrTankManagementsRow.fromJson(Map<String, dynamic> json) =>
      TrTankManagementsRow(
        tankManagementId: json["TankManagementID"],
        plant: json["Plant"],
        tankManagementNo: json["TankManagementNo"],
        workStatusCode: json["WorkStatusCode"],
        workStatus: json["WorkStatus"],
        workDate: json["WorkDate"],
        workTime: json["WorkTime"],
        driverName: json["DriverName"],
        tankNo: json["TankNo"],
        tankType: json["TankType"],
        cleanType: json["CleanType"],
      );
}
