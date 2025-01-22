// To parse this JSON data, do
//
//     final getIdModel = getIdModelFromJson(jsonString);

import 'dart:convert';

GetIdModel getIdModelFromJson(String str) => GetIdModel.fromJson(json.decode(str));

String getIdModelToJson(GetIdModel data) => json.encode(data.toJson());

class GetIdModel {
    int code;
    String result;
    String message;
    GetIdModelData data;

    GetIdModel({
        required this.code,
        required this.result,
        required this.message,
        required this.data,
    });

    factory GetIdModel.fromJson(Map<String, dynamic> json) => GetIdModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: GetIdModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": data.toJson(),
    };
}

class GetIdModelData {
    String appname;
    String applicationName;
    String applicationNameAlt;
    String pageReDirect;
    String accessToken;

    GetIdModelData({
        required this.appname,
        required this.applicationName,
        required this.applicationNameAlt,
        required this.pageReDirect,
        required this.accessToken,
    });

    factory GetIdModelData.fromJson(Map<String, dynamic> json) => GetIdModelData(
        appname: json["appname"],
        applicationName: json["ApplicationName"],
        applicationNameAlt: json["ApplicationName_Alt"],
        pageReDirect: json["PageReDirect"],
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "appname": appname,
        "ApplicationName": applicationName,
        "ApplicationName_Alt": applicationNameAlt,
        "PageReDirect": pageReDirect,
        "accessToken": accessToken,
    };
}
