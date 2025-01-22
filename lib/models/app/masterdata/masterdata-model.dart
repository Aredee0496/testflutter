// To parse this JSON data, do
//
//     final masterDataModel = masterDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-attatchments-model.dart';
import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-model.dart';
import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';

MasterDataModel masterDataModelFromJson(String str) =>
    MasterDataModel.fromJson(json.decode(str));

String masterDataModelToJson(MasterDataModel data) =>
    json.encode(data.toJson());

class MasterDataModel {
  List<MsPlant> msPlant;
  List<MsDriver> msDriver;
  List<MsReason> msReason;
  List<JobStatusModel> msJobStatus;
  List<JobMovingModel> jobMovings;
  List<TrJobMovingAttatchmentsModel> trJobMovingAttatchments;

  MasterDataModel(
      {required this.msPlant,
      required this.msDriver,
      required this.msReason,
      required this.msJobStatus,
      required this.jobMovings,
      required this.trJobMovingAttatchments});

  factory MasterDataModel.fromJson(Map<String, dynamic> json) =>
      MasterDataModel(
        jobMovings: List<JobMovingModel>.from(
            json["TRJobMovings"].map((x) => JobMovingModel.fromJson(x))),
        trJobMovingAttatchments: List<TrJobMovingAttatchmentsModel>.from(
            json["TRJobMovingAttatchments"]
                .map((x) => TrJobMovingAttatchmentsModel.fromJson(x))),
        msPlant:
            List<MsPlant>.from(json["MSPlant"].map((x) => MsPlant.fromJson(x))),
        msDriver: List<MsDriver>.from(
            json["MSDriver"].map((x) => MsDriver.fromJson(x))),
        msReason: List<MsReason>.from(
            json["MSReason"].map((x) => MsReason.fromJson(x))),
        msJobStatus: List<JobStatusModel>.from(
            json["MSJobStatuss"].map((x) => JobStatusModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MSPlant": List<dynamic>.from(msPlant.map((x) => x.toJson())),
        "MSDriver": List<dynamic>.from(msDriver.map((x) => x.toJson())),
        "MSReason": List<dynamic>.from(msReason.map((x) => x.toJson())),
      };
}

class MsDriver {
  String driverId;
  String driver;
  String? email;
  String? description;
  int status;
  List<MsLicenseNo> msLicenseNos;

  MsDriver({
    required this.driverId,
    required this.driver,
    this.email,
    this.description,
    required this.status,
    required this.msLicenseNos,
  });

  factory MsDriver.fromJson(Map<String, dynamic> json) => MsDriver(
        driverId: json["DriverID"],
        driver: json["Driver"],
        email: json["Email"],
        description: json["Description"],
        status: json["Status"],
        msLicenseNos: List<MsLicenseNo>.from(
            json["MSLicenseNos"].map((x) => MsLicenseNo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DriverID": driverId,
        "Driver": driver,
        "Email": email,
        "Description": description,
        "Status": status,
        "MSLicenseNos": List<dynamic>.from(msLicenseNos.map((x) => x.toJson())),
      };
}

class MsLicenseNo {
  String licenseNoId;
  String licenseNo;
  String? description;

  MsLicenseNo({
    required this.licenseNoId,
    required this.licenseNo,
    this.description,
  });

  factory MsLicenseNo.fromJson(Map<String, dynamic> json) => MsLicenseNo(
        licenseNoId: json["LicenseNoID"],
        licenseNo: json["LicenseNo"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "LicenseNoID": licenseNoId,
        "LicenseNo": licenseNo,
        "Description": description,
      };
}

class MsPlant {
  String plantCode;
  String plantName;
  int status;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  MsPlant({
    required this.plantCode,
    required this.plantName,
    required this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory MsPlant.fromJson(Map<String, dynamic> json) => MsPlant(
        plantCode: json["PlantCode"],
        plantName: json["PlantName"],
        status: json["Status"],
        createdBy: json["CreatedBy"] ?? "",
        updatedBy: json["UpdatedBy"] ?? "",
        deletedBy: json["DeletedBy"] ?? "",
        createdAt: json["CreatedAt"] ?? "",
        updatedAt: json["UpdatedAt"] ?? "",
        deletedAt: json["DeletedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "PlantCode": plantCode,
        "PlantName": plantName,
        "Status": status,
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
        "DeletedBy": deletedBy,
        "CreatedAt": createdAt,
        "UpdatedAt": updatedAt,
        "DeletedAt": deletedAt,
      };
}

class MsReason {
  String reasonId;
  String reason;
  String? description;
  int status;

  MsReason({
    required this.reasonId,
    required this.reason,
    this.description,
    required this.status,
  });

  factory MsReason.fromJson(Map<String, dynamic> json) => MsReason(
        reasonId: json["ReasonID"],
        reason: json["Reason"],
        description: json["Description"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "ReasonID": reasonId,
        "Reason": reason,
        "Description": description,
        "Status": status,
      };
}
