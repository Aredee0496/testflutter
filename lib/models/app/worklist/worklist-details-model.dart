// To parse this JSON data, do
//
//     final worklistDetailsModel = worklistDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/masterdata/msjobstatuss-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/mslicense-no2s-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/mslicense-nos-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/msquantity-uoms-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/mstemplate-checklists-model.dart';
import 'package:starlightserviceapp/models/app/masterdata/mszdatas-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trsap-shipment-outbounds-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-attachment-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-evaluations-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-expenses-rategroup1-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklist-shipments-model.dart';
import 'package:starlightserviceapp/models/app/worklist/detalils/trworklists-model.dart';

WorklistDetailsModel worklistDetailsModelFromJson(String str) =>
    WorklistDetailsModel.fromJson(json.decode(str));

class WorklistDetailsModel {
  int code;
  String result;
  String message;
  DataWorklistDetails data;

  WorklistDetailsModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory WorklistDetailsModel.fromJson(Map<String, dynamic> json) =>
      WorklistDetailsModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: DataWorklistDetails.fromJson(json["data"]),
      );
}

class DataWorklistDetails {
  TrWorklists trWorklists;
  TrWorklistShipments trWorklistShipments;
  TrWorklistExpensesRateGroup trWorklistExpensesRateGroup1;
  TrWorklistExpensesRateGroup trWorklistExpensesRateGroup2;
  TrWorklistEvaluations trWorklistEvaluations;
  TrWorklistAttachment trWorklistAttatchments;
  TrsapShipmentOutbounds trsapShipmentOutbounds;
  MsJobStatuss msJobStatuss;
  MsLicenseNos msLicenseNos;
  MsLicenseNo2s msLicenseNo2S;
  MszDatas mszDatas;
  MSQuantityUOMs msQuantityUoMs;
  MsTemplateChecklists msTemplateChecklists;

  DataWorklistDetails({
    required this.trWorklists,
    required this.trWorklistShipments,
    required this.trWorklistExpensesRateGroup1,
    required this.trWorklistExpensesRateGroup2,
    required this.trWorklistEvaluations,
    required this.trWorklistAttatchments,
    required this.trsapShipmentOutbounds,
    required this.msJobStatuss,
    required this.msLicenseNos,
    required this.msLicenseNo2S,
    required this.mszDatas,
    required this.msQuantityUoMs,
    required this.msTemplateChecklists,
  });

  factory DataWorklistDetails.fromJson(Map<String, dynamic> json) =>
      DataWorklistDetails(
        trWorklists: TrWorklists.fromJson(json["TRWorklists"]),
        trWorklistShipments:
            TrWorklistShipments.fromJson(json["TRWorklistShipments"]),
        trWorklistExpensesRateGroup1: TrWorklistExpensesRateGroup.fromJson(
            json["TRWorklistExpensesRateGroup1"]),
        trWorklistExpensesRateGroup2: TrWorklistExpensesRateGroup.fromJson(
            json["TRWorklistExpensesRateGroup2"]),
        trWorklistEvaluations:
            TrWorklistEvaluations.fromJson(json["TRWorklistEvaluations"]),
        trWorklistAttatchments:
            TrWorklistAttachment.fromJson(json["TRWorklistAttatchments"]),
        trsapShipmentOutbounds:
            TrsapShipmentOutbounds.fromJson(json["TRSAPShipmentOutbounds"]),
        msJobStatuss: MsJobStatuss.fromJson(json["MSJobStatuss"]),
        msLicenseNos: MsLicenseNos.fromJson(json["MSLicenseNos"]),
        msLicenseNo2S: MsLicenseNo2s.fromJson(json["MSLicenseNo2s"]),
        mszDatas: MszDatas.fromJson(json["MSZDatas"]),
        msQuantityUoMs: MSQuantityUOMs.fromJson(json["MSQuantityUOMs"]),
        msTemplateChecklists:
            MsTemplateChecklists.fromJson(json["MSTemplateChecklists"]),
      );
}
