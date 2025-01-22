// To parse this JSON data, do
//
//     final jobMovingModel = jobMovingModelFromJson(jsonString);

import 'dart:convert';

JobMovingModel jobMovingModelFromJson(String str) =>
    JobMovingModel.fromJson(json.decode(str));

String jobMovingModelToJson(JobMovingModel data) => json.encode(data.toJson());

class JobMovingModel {
  String? jobId;
  String? jobStatus;
  dynamic jobStatusDescription;
  String? documentNo;
  String? plantCode;
  String? dateWork;
  String? containerNo;
  String? remark;
  String? driverId;
  String? driver;
  String? email;
  String? licenseNoId;
  String? licenseNo;
  String? supplementary2;
  String? reasonId;
  String? reason;
  String? locationStart;
  String? locationEnd;
  String? createbyTh;
  String? createbyEn;
  dynamic status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  JobMovingModel({
    this.jobId,
    this.jobStatus,
    this.jobStatusDescription,
    this.documentNo,
    this.plantCode,
    this.dateWork,
    this.containerNo,
    this.remark,
    this.driverId,
    this.driver,
    this.email,
    this.licenseNoId,
    this.licenseNo,
    this.supplementary2,
    this.reasonId,
    this.reason,
    this.locationStart,
    this.locationEnd,
    this.createbyTh,
    this.createbyEn,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory JobMovingModel.fromJson(Map<String, dynamic> json) => JobMovingModel(
      jobId: json["JobID"],
      jobStatus: json["JobStatus"],
      jobStatusDescription: json["JobStatusDescription"] ?? "",
      documentNo: json["DocumentNo"],
      plantCode: json["PlantCode"],
      dateWork: json["DateWork"],
      containerNo: json["ContainerNo"],
      remark: json["Remark"],
      driverId: json["DriverID"],
      driver: json["Driver"],
      email: json["Email"],
      licenseNoId: json["LicenseNoID"],
      licenseNo: json["LicenseNo"],
      supplementary2: json["Supplementary2"],
      reasonId: json["ReasonID"],
      reason: json["Reason"],
      locationStart: json["LocationStart"],
      locationEnd: json["LocationEnd"],
      createbyTh: json["CreatebyTH"],
      createbyEn: json["CreatebyEN"],
      status: json["Status"],
      createdBy: json["CreatedBy"] ?? "",
      updatedBy: json["UpdatedBy"] ?? "",
      createdAt: json["CreatedAt"] ?? "",
      updatedAt: json["UpdatedAt"] ?? "");
  Map<String, dynamic> toJson() => {
        "JobID": jobId,
        "JobStatus": jobStatus,
        "JobStatusDescription": jobStatusDescription,
        "DocumentNo": documentNo,
        "PlantCode": plantCode,
        "DateWork": dateWork,
        "ContainerNo": containerNo,
        "Remark": remark,
        "DriverID": driverId,
        "Driver": driver,
        "Email": email,
        "LicenseNoID": licenseNoId,
        "LicenseNo": licenseNo,
        "Supplementary2": supplementary2,
        "ReasonID": reasonId,
        "Reason": reason,
        "LocationStart": locationStart,
        "LocationEnd": locationEnd,
        "CreatebyTH": createbyTh,
        "CreatebyEN": createbyEn,
        "Status": status,
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
        "CreatedAt": createdAt,
        "UpdatedAt": updatedAt,
      };
}
