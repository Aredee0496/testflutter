// To parse this JSON data, do
//
//     final switchPlantModel = switchPlantModelFromJson(jsonString);

import 'dart:convert';

SwitchPlantModel switchPlantModelFromJson(String str) =>
    SwitchPlantModel.fromJson(json.decode(str));

String switchPlantModelToJson(SwitchPlantModel data) =>
    json.encode(data.toJson());

class SwitchPlantModel {
  int code;
  String result;
  String message;
  Data data;

  SwitchPlantModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory SwitchPlantModel.fromJson(Map<String, dynamic> json) =>
      SwitchPlantModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String accesstoken;
  String refreshtoken;

  Data({
    required this.accesstoken,
    required this.refreshtoken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accesstoken: json["accesstoken"],
        // refreshtoken: json["refreshtoken"],
        refreshtoken: json["refreshtokenmobile"],
      );

  Map<String, dynamic> toJson() => {
        "accesstoken": accesstoken,
        "refreshtoken": refreshtoken,
      };
}
