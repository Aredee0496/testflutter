// To parse this JSON data, do
//
//     final trTransportClearingSearchModel = trTransportClearingSearchModelFromJson(jsonString);

import 'dart:convert';

TrTransportClearingSearchModel trTransportClearingSearchModelFromJson(
        String str) =>
    TrTransportClearingSearchModel.fromJson(json.decode(str));

class TrTransportClearingSearchModel {
  int code;
  String result;
  String message;
  Data data;

  TrTransportClearingSearchModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory TrTransportClearingSearchModel.fromJson(Map<String, dynamic> json) =>
      TrTransportClearingSearchModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int count;
  List<TrTransportClearingSearchRow> rows;

  Data({
    required this.count,
    required this.rows,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        rows: List<TrTransportClearingSearchRow>.from(
            json["rows"].map((x) => TrTransportClearingSearchRow.fromJson(x))),
      );
}

class TrTransportClearingSearchRow {
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

  TrTransportClearingSearchRow({
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
  });

  factory TrTransportClearingSearchRow.fromJson(Map<String, dynamic> json) =>
      TrTransportClearingSearchRow(
        worklistId: json["WorklistID"],
        worklistDocumentNo: json["WorklistDocumentNo"],
        workdate: json["Workdate"],
        jobStatus: json["JobStatus"],
        jobStatusDescription: json["JobStatusDescription"],
        routeCode: json["RouteCode"],
        route: json["Route"],
        workType: json["WorkType"],
        product: json["Product"],
        remarkAdmin: json["RemarkAdmin"],
      );
}
