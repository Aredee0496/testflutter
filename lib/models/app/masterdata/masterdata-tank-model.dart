// To parse this JSON data, do
//
//     final masterDataModel = masterDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';
import 'package:starlightserviceapp/models/app/tank-driver/res-tank-details-model.dart';

MasterDataTankModel masterDataModelFromJson(String str) =>
    MasterDataTankModel.fromJson(json.decode(str));

class MasterDataTankModel {
  MasterDataTankModelRows msJobStatus;
  MsTanks msTanks;
  MsDrivers msDrivers;
  MsTankTypes msTankTypes;
  MsStaffTanks msStaffTanks;

  MasterDataTankModel({
    required this.msJobStatus,
    required this.msTanks,
    required this.msDrivers,
    required this.msTankTypes,
    required this.msStaffTanks,
  });

  factory MasterDataTankModel.fromJson(Map<String, dynamic> json) =>
      MasterDataTankModel(
          msJobStatus: MasterDataTankModelRows.fromJson(json["MSJobStatuss"]),
          msTanks: MsTanks.fromJson(json["MSTanks"]),
          msDrivers: MsDrivers.fromJson(json["MSDrivers"]),
          msTankTypes: MsTankTypes.fromJson(json["MSTankTypes"]),
          msStaffTanks: MsStaffTanks.fromJson(json["MSStaffTanks"]));
}

class MasterDataTankModelRows {
  int count;
  List<JobStatusModel> rows;

  MasterDataTankModelRows({
    required this.count,
    required this.rows,
  });

  factory MasterDataTankModelRows.fromJson(Map<String, dynamic> json) =>
      MasterDataTankModelRows(
        count: json["count"],
        rows: List<JobStatusModel>.from(
            json["rows"].map((x) => JobStatusModel.fromJson(x))),
      );
}

class MsStaffTanks {
  int count;
  List<MsStaffTanksRow> rows;

  MsStaffTanks({
    required this.count,
    required this.rows,
  });

  factory MsStaffTanks.fromJson(Map<String, dynamic> json) => MsStaffTanks(
        count: json["count"],
        rows: List<MsStaffTanksRow>.from(
            json["rows"].map((x) => MsStaffTanksRow.fromJson(x))),
      );
}

class MsStaffTanksRow {
  String? staffId;
  String? staffName;
  String? staffCode;
  String? token;

  MsStaffTanksRow({
    this.staffId,
    this.staffName,
    this.staffCode,
    this.token,
  });

  factory MsStaffTanksRow.fromJson(Map<String, dynamic> json) =>
      MsStaffTanksRow(
        staffId: json["StaffID"],
        staffName: json["StaffName"],
        staffCode: json["StaffCode"],
        token: json["Token"],
      );
}
