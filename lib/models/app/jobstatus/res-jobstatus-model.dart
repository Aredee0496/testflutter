//     final ResJobStatusModel = ResJobStatusModelFromJson(jsonString);

import 'dart:convert';

import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';

ResJobStatusModel ResJobStatusModelFromJson(String str) =>
    ResJobStatusModel.fromJson(json.decode(str));

String ResJobStatusModelToJson(ResJobStatusModel data) =>
    json.encode(data.toJson());

class ResJobStatusModel {
  int code;
  String result;
  String message;
  List<JobStatusModel> data;

  ResJobStatusModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResJobStatusModel.fromJson(Map<String, dynamic> json) =>
      ResJobStatusModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: List<JobStatusModel>.from(
            json["data"].map((x) => JobStatusModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": List<JobStatusModel>.from(data.map((x) => x.toJson())),
      };
}
