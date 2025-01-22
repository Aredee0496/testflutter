// To parse this JSON data, do
//
//     final resTankTankSearchModel = resTankTankSearchModelFromJson(jsonString);

import 'dart:convert';

ResTankTankSearchModel resTankTankSearchModelFromJson(String str) =>
    ResTankTankSearchModel.fromJson(json.decode(str));

class ResTankTankSearchModel {
  int code;
  String result;
  String message;
  Data data;

  ResTankTankSearchModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResTankTankSearchModel.fromJson(Map<String, dynamic> json) =>
      ResTankTankSearchModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  TrTankManagementsData trTankManagements;

  Data({
    required this.trTankManagements,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trTankManagements:
            TrTankManagementsData.fromJson(json["TRTankManagements"]),
      );
}

class TrTankManagementsData {
  int count;
  List<TrTankManagementsTankRow> rows;

  TrTankManagementsData({
    required this.count,
    required this.rows,
  });

  factory TrTankManagementsData.fromJson(Map<String, dynamic> json) =>
      TrTankManagementsData(
        count: json["count"],
        rows: List<TrTankManagementsTankRow>.from(
            json["rows"].map((x) => TrTankManagementsTankRow.fromJson(x))),
      );
}

class TrTankManagementsTankRow {
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

  TrTankManagementsTankRow({
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

  factory TrTankManagementsTankRow.fromJson(Map<String, dynamic> json) =>
      TrTankManagementsTankRow(
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
