// To parse this JSON data, do
//
//     final resTankDetailsModel = resTankDetailsModelFromJson(jsonString);

import 'dart:convert';

ResTankDetailsModel resTankDetailsModelFromJson(String str) =>
    ResTankDetailsModel.fromJson(json.decode(str));

class ResTankDetailsModel {
  int code;
  String result;
  String message;
  TankDetailsDataModel data;

  ResTankDetailsModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResTankDetailsModel.fromJson(Map<String, dynamic> json) =>
      ResTankDetailsModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: TankDetailsDataModel.fromJson(json["data"]),
      );
}

class TankDetailsDataModel {
  TrTankManagements trTankManagements;
  TrTankManagementDetails trTankManagementDetails;
  // MsDrivers trTankManagementAttatchments;
  MsJobStatuss msJobStatuss;
  MsTanks msTanks;
  MsDrivers msDrivers;
  MsTankTypes msTankTypes;

  TankDetailsDataModel({
    required this.trTankManagements,
    required this.trTankManagementDetails,
    // required this.trTankManagementAttatchments,
    required this.msJobStatuss,
    required this.msTanks,
    required this.msDrivers,
    required this.msTankTypes,
  });

  factory TankDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      TankDetailsDataModel(
        trTankManagements:
            TrTankManagements.fromJson(json["TRTankManagements"]),
        trTankManagementDetails:
            TrTankManagementDetails.fromJson(json["TRTankManagementDetails"]),
        // trTankManagementAttatchments:
        //     MsDrivers.fromJson(json["TRTankManagementAttatchments"]),
        msJobStatuss: MsJobStatuss.fromJson(json["MSJobStatuss"]),
        msTanks: MsTanks.fromJson(json["MSTanks"]),
        msDrivers: MsDrivers.fromJson(json["MSDrivers"]),
        msTankTypes: MsTankTypes.fromJson(json["MSTankTypes"]),
      );
}

class MsDrivers {
  int count;
  List<MsDriversRow> rows;

  MsDrivers({
    required this.count,
    required this.rows,
  });

  factory MsDrivers.fromJson(Map<String, dynamic> json) => MsDrivers(
        count: json["count"],
        rows: List<MsDriversRow>.from(
            json["rows"].map((x) => MsDriversRow.fromJson(x))),
      );
}

class MsDriversRow {
  String driverId;
  String driver;
  String? email;
  String? description;
  int status;
  String? token;

  MsDriversRow({
    required this.driverId,
    required this.driver,
    this.email,
    this.description,
    required this.status,
    this.token,
  });

  factory MsDriversRow.fromJson(Map<String, dynamic> json) => MsDriversRow(
        driverId: json["DriverID"],
        driver: json["Driver"],
        email: json["Email"],
        description: json["Description"],
        status: json["Status"],
        token: json["Token"],
      );
}

class MsJobStatuss {
  int count;
  List<MsJobStatussRow> rows;

  MsJobStatuss({
    required this.count,
    required this.rows,
  });

  factory MsJobStatuss.fromJson(Map<String, dynamic> json) => MsJobStatuss(
        count: json["count"],
        rows: List<MsJobStatussRow>.from(
            json["rows"].map((x) => MsJobStatussRow.fromJson(x))),
      );
}

class MsJobStatussRow {
  String jobStatusCode;
  String? description;
  int seq;
  int status;

  MsJobStatussRow({
    required this.jobStatusCode,
    this.description,
    required this.seq,
    required this.status,
  });

  factory MsJobStatussRow.fromJson(Map<String, dynamic> json) =>
      MsJobStatussRow(
        jobStatusCode: json["JobStatusCode"],
        description: json["Description"],
        seq: json["Seq"],
        status: json["Status"],
      );
}

class MsTankTypes {
  int count;
  List<MsTankTypesRow> rows;

  MsTankTypes({
    required this.count,
    required this.rows,
  });

  factory MsTankTypes.fromJson(Map<String, dynamic> json) => MsTankTypes(
        count: json["count"],
        rows: List<MsTankTypesRow>.from(
            json["rows"].map((x) => MsTankTypesRow.fromJson(x))),
      );
}

class MsTankTypesRow {
  String tankTypeId;
  String tankType;
  List<MsCleanType> msCleanTypes;

  MsTankTypesRow({
    required this.tankTypeId,
    required this.tankType,
    required this.msCleanTypes,
  });

  factory MsTankTypesRow.fromJson(Map<String, dynamic> json) => MsTankTypesRow(
        tankTypeId: json["TankTypeID"],
        tankType: json["TankType"],
        msCleanTypes: List<MsCleanType>.from(
            json["MSCleanTypes"].map((x) => MsCleanType.fromJson(x))),
      );
}

class MsCleanType {
  String cleanTypeId;
  String cleanType;

  MsCleanType({
    required this.cleanTypeId,
    required this.cleanType,
  });

  factory MsCleanType.fromJson(Map<String, dynamic> json) => MsCleanType(
        cleanTypeId: json["CleanTypeID"],
        cleanType: json["CleanType"],
      );
}

class MsTanks {
  int count;
  List<MsTanksRow> rows;

  MsTanks({
    required this.count,
    required this.rows,
  });

  factory MsTanks.fromJson(Map<String, dynamic> json) => MsTanks(
        count: json["count"],
        rows: List<MsTanksRow>.from(
            json["rows"].map((x) => MsTanksRow.fromJson(x))),
      );
}

class MsTanksRow {
  String tankId;
  String tankNo;

  MsTanksRow({
    required this.tankId,
    required this.tankNo,
  });

  factory MsTanksRow.fromJson(Map<String, dynamic> json) => MsTanksRow(
        tankId: json["TankID"],
        tankNo: json["TankNo"],
      );

  Map<String, dynamic> toJson() => {
        "TankID": tankId,
        "TankNo": tankNo,
      };
}

class TrTankManagementDetails {
  int count;
  List<TrTankManagementDetailsRow> rows;

  TrTankManagementDetails({
    required this.count,
    required this.rows,
  });

  factory TrTankManagementDetails.fromJson(Map<String, dynamic> json) =>
      TrTankManagementDetails(
        count: json["count"],
        rows: List<TrTankManagementDetailsRow>.from(
            json["rows"].map((x) => TrTankManagementDetailsRow.fromJson(x))),
      );
}

class TrTankManagementDetailsRow {
  String tankManagmentDetailId;
  String tankManagementId;
  String staffId;
  String staffName;
  String staffCode;

  TrTankManagementDetailsRow({
    required this.tankManagmentDetailId,
    required this.tankManagementId,
    required this.staffId,
    required this.staffName,
    required this.staffCode,
  });

  factory TrTankManagementDetailsRow.fromJson(Map<String, dynamic> json) =>
      TrTankManagementDetailsRow(
        tankManagmentDetailId: json["TankManagmentDetailID"],
        tankManagementId: json["TankManagementID"],
        staffId: json["StaffID"],
        staffName: json["StaffName"],
        staffCode: json["StaffCode"],
      );

  Map<String, dynamic> toJson() => {
        "TankManagmentDetailID": tankManagmentDetailId,
        "TankManagementID": tankManagementId,
        "StaffID": staffId,
        "StaffName": staffName,
        "StaffCode": staffCode,
      };
}

class TrTankManagements {
  int count;
  List<TrTankManagementsDetailsRow> rows;

  TrTankManagements({
    required this.count,
    required this.rows,
  });

  factory TrTankManagements.fromJson(Map<String, dynamic> json) =>
      TrTankManagements(
        count: json["count"],
        rows: List<TrTankManagementsDetailsRow>.from(
            json["rows"].map((x) => TrTankManagementsDetailsRow.fromJson(x))),
      );
}

class TrTankManagementsDetailsRow {
  String? tankManagementId;
  String? plant;
  String? tankManagementNo;
  String? workStatusCode;
  String? workStatus;
  String? tankNo;
  String? tankType;
  String? driverName;
  String? tankManagementDate;
  String? workDate;
  String? workTime;
  String? acceptWorkDate;
  String? acceptWorkTime;
  String? closeWorkDate;
  String? closeWorkTime;
  dynamic staffSumary;
  String? driverID;
  String? cleanTypeID;
  String? cleanType;

  TrTankManagementsDetailsRow({
    this.tankManagementId,
    this.plant,
    this.tankManagementNo,
    this.workStatusCode,
    this.workStatus,
    this.tankNo,
    this.tankType,
    this.driverName,
    this.tankManagementDate,
    this.workDate,
    this.workTime,
    this.acceptWorkDate,
    this.acceptWorkTime,
    this.closeWorkDate,
    this.closeWorkTime,
    this.staffSumary,
    this.driverID,
    this.cleanTypeID,
    this.cleanType,
  });

  factory TrTankManagementsDetailsRow.fromJson(Map<String, dynamic> json) =>
      TrTankManagementsDetailsRow(
        tankManagementId: json["TankManagementID"],
        plant: json["Plant"],
        tankManagementNo: json["TankManagementNo"],
        workStatusCode: json["WorkStatusCode"],
        workStatus: json["WorkStatus"],
        tankNo: json["TankNo"],
        tankType: json["TankType"],
        driverName: json["DriverName"],
        tankManagementDate: json["TankManagementDate"],
        workDate: json["WorkDate"],
        workTime: json["WorkTime"],
        acceptWorkDate: json["AcceptWorkDate"],
        acceptWorkTime: json["AcceptWorkTime"],
        closeWorkDate: json["CloseWorkDate"],
        closeWorkTime: json["CloseWorkTime"],
        staffSumary: json["StaffSumary"],
        driverID: json["DriverID"],
        cleanTypeID: json["CleanTypeID"],
        cleanType: json["CleanType"],
      );
}
