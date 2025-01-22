// To parse this JSON data, do
//
//     final worklistModel = worklistModelFromJson(jsonString);

import 'dart:convert';

WorklistModel worklistModelFromJson(String str) =>
    WorklistModel.fromJson(json.decode(str));

String worklistModelToJson(WorklistModel data) => json.encode(data.toJson());

class WorklistModel {
  String? worklistId;
  String? worklistDocumentNo;
  String? workdate;
  String? jobStatus;
  String? jobStatusDescription;
  String? routeCode;
  String? route;
  String? workType;
  String? product;
  String? remarkAdmin;
  String? remarkEditDocument;
  int? status;

  WorklistModel({
    this.worklistId,
    this.worklistDocumentNo,
    this.workdate,
    this.jobStatus,
    this.jobStatusDescription,
    this.routeCode,
    this.route,
    this.workType,
    this.product,
    this.remarkAdmin,
    this.remarkEditDocument,
    this.status,
  });

  factory WorklistModel.fromJson(Map<String, dynamic> json) => WorklistModel(
        worklistId: json["WorklistID"] ?? "",
        worklistDocumentNo: json["WorklistDocumentNo"] ?? "",
        workdate: json["Workdate"] ?? "",
        jobStatus: json["JobStatus"] ?? "",
        jobStatusDescription: json["JobStatusDescription"] ?? "",
        routeCode: json["RouteCode"] ?? "",
        route: json["Route"] ?? "",
        workType: json["WorkType"] ?? "",
        product: json["Product"] ?? "",
        remarkAdmin: json["RemarkAdmin"] ?? "",
        remarkEditDocument: json["RemarkEditDocument"] ?? "",
        status: json["Status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "WorklistID": worklistId,
        "WorklistDocumentNo": worklistDocumentNo,
        "Workdate": workdate,
        "JobStatus": jobStatus,
        "JobStatusDescription": jobStatusDescription,
        "RouteCode": routeCode,
        "Route": route,
        "WorkType": workType,
        "Product": product,
        "RemarkAdmin": remarkAdmin,
        "Status": status,
      };
}
