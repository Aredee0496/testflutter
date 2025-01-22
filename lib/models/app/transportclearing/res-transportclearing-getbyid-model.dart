// To parse this JSON data, do
//
//     final resTransportClearingGetByIdModel = resTransportClearingGetByIdModelFromJson(jsonString);

import 'dart:convert';

ResTransportClearingGetByIdModel resTransportClearingGetByIdModelFromJson(
        String str) =>
    ResTransportClearingGetByIdModel.fromJson(json.decode(str));

class ResTransportClearingGetByIdModel {
  int code;
  String result;
  String message;
  Data data;

  ResTransportClearingGetByIdModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResTransportClearingGetByIdModel.fromJson(
          Map<String, dynamic> json) =>
      ResTransportClearingGetByIdModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  TrWorklistsInTrc trWorklists;
  TrWorklistExpenses trWorklistExpenses;

  Data({
    required this.trWorklists,
    required this.trWorklistExpenses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trWorklists: TrWorklistsInTrc.fromJson(json["TRWorklists"]),
        trWorklistExpenses:
            TrWorklistExpenses.fromJson(json["TRWorklistExpenses"]),
      );
}

class TrWorklistExpenses {
  int count;
  List<TrWorklistExpensesRow> rows;

  TrWorklistExpenses({
    required this.count,
    required this.rows,
  });

  factory TrWorklistExpenses.fromJson(Map<String, dynamic> json) =>
      TrWorklistExpenses(
        count: json["count"],
        rows: List<TrWorklistExpensesRow>.from(
            json["rows"].map((x) => TrWorklistExpensesRow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class TrWorklistExpensesRow {
  String? expenId;
  String? worklistId;
  dynamic rateGroup;
  String? rateGroupDescription;
  dynamic seq;
  String? rateId;
  String? rate;
  dynamic price;
  String? rateUnit;
  dynamic rateAmount;
  dynamic rateSum;

  TrWorklistExpensesRow({
    this.expenId,
    this.worklistId,
    this.rateGroup,
    this.rateGroupDescription,
    this.seq,
    this.rateId,
    this.rate,
    this.price,
    this.rateUnit,
    this.rateAmount,
    this.rateSum,
  });

  factory TrWorklistExpensesRow.fromJson(Map<String, dynamic> json) =>
      TrWorklistExpensesRow(
        expenId: json["ExpenID"],
        worklistId: json["WorklistID"],
        rateGroup: json["RateGroup"],
        rateGroupDescription: json["RateGroupDescription"],
        seq: json["Seq"],
        rateId: json["RateID"],
        rate: json["Rate"],
        price: json["Price"],
        rateUnit: json["RateUnit"],
        rateAmount: json["RateAmount"],
        rateSum: json["RateSum"],
      );

  Map<String, dynamic> toJson() => {
        "ExpenID": expenId,
        "WorklistID": worklistId,
        "RateGroup": rateGroup,
        "RateGroupDescription": rateGroupDescription,
        "Seq": seq,
        "RateID": rateId,
        "Rate": rate,
        "Price": price,
        "RateUnit": rateUnit,
        "RateAmount": rateAmount,
        "RateSum": rateSum,
      };
}

class TrWorklistsInTrc {
  int count;
  List<TrWorklistsInTrcRow> rows;

  TrWorklistsInTrc({
    required this.count,
    required this.rows,
  });

  factory TrWorklistsInTrc.fromJson(Map<String, dynamic> json) =>
      TrWorklistsInTrc(
        count: json["count"],
        rows: List<TrWorklistsInTrcRow>.from(
            json["rows"].map((x) => TrWorklistsInTrcRow.fromJson(x))),
      );
}

class TrWorklistsInTrcRow {
  String? worklistId;
  String? worklistDocumentNo;
  String? plant;
  String? workdate;
  String? jobStatus;
  String? jobStatusDescription;
  String? routeCode;
  String? route;
  String? driverName;
  String? licenseNo;
  String? remarkAdmin;
  dynamic addMoneyRateGroup1;
  dynamic delMoneyRateGroup1;
  dynamic addMoneyRateGroup2;
  dynamic delMoneyRateGroup2;
  dynamic totalExpenseRateGroup1;
  dynamic totalExpenseRateGroup2;
  dynamic sumALLGroup1;
  dynamic sumALLGroup2;
  String? booking;
  dynamic booking2;
  String? clearTransactionDate;
  String? transferDate;
  dynamic fuelSumSAP;
  dynamic driverAllowanceSAP;

  TrWorklistsInTrcRow({
    this.worklistId,
    this.worklistDocumentNo,
    this.plant,
    this.workdate,
    this.jobStatus,
    this.jobStatusDescription,
    this.routeCode,
    this.route,
    this.driverName,
    this.licenseNo,
    this.remarkAdmin,
    this.addMoneyRateGroup1,
    this.delMoneyRateGroup1,
    this.addMoneyRateGroup2,
    this.delMoneyRateGroup2,
    this.totalExpenseRateGroup1,
    this.totalExpenseRateGroup2,
    this.sumALLGroup1,
    this.sumALLGroup2,
    this.booking,
    this.booking2,
    this.clearTransactionDate,
    this.transferDate,
    this.fuelSumSAP,
    this.driverAllowanceSAP,
  });

  factory TrWorklistsInTrcRow.fromJson(Map<String, dynamic> json) =>
      TrWorklistsInTrcRow(
        worklistId: json["WorklistID"],
        worklistDocumentNo: json["WorklistDocumentNo"],
        plant: json["Plant"],
        workdate: json["Workdate"],
        jobStatus: json["JobStatus"],
        jobStatusDescription: json["JobStatusDescription"],
        routeCode: json["RouteCode"],
        route: json["Route"],
        driverName: json["DriverName"],
        licenseNo: json["LicenseNo"],
        remarkAdmin: json["RemarkAdmin"],
        addMoneyRateGroup1: json["AddMoneyRateGroup1"],
        delMoneyRateGroup1: json["DelMoneyRateGroup1"],
        addMoneyRateGroup2: json["AddMoneyRateGroup2"],
        delMoneyRateGroup2: json["DelMoneyRateGroup2"],
        totalExpenseRateGroup1: json["TotalExpenseRateGroup1"],
        totalExpenseRateGroup2: json["TotalExpenseRateGroup2"],
        sumALLGroup1: json["SumALLGroup1"],
        sumALLGroup2: json["SumALLGroup2"],
        booking: json["Booking"],
        booking2: json["Booking2"],
        clearTransactionDate: json["ClearTransactionDate"],
        transferDate: json["TransferDate"],
        fuelSumSAP: json["FuelSumSAP"],
        driverAllowanceSAP: json["DriverAllowanceSAP"],
      );
}
