// To parse this JSON data, do
//
//     final resJobMovingModel = resJobMovingModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/jobmoving/jobmoving-model.dart';

ResJobMovingModel resJobMovingModelFromJson(String str) =>
    ResJobMovingModel.fromJson(json.decode(str));

String resJobMovingModelToJson(ResJobMovingModel data) =>
    json.encode(data.toJson());

class ResJobMovingModel {
  int code;
  String result;
  String message;
  List<JobMovingModel> data;

  ResJobMovingModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResJobMovingModel.fromJson(Map<String, dynamic> json) =>
      ResJobMovingModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: List<JobMovingModel>.from(
            json["data"].map((x) => JobMovingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": List<JobMovingModel>.from(data.map((x) => x.toJson())),
      };
}
