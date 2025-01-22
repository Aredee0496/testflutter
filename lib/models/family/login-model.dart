// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    int code;
    String result;
    String message;
    LoginModelData data;

    LoginModel({
        required this.code,
        required this.result,
        required this.message,
        required this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data: LoginModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": data.toJson(),
    };
}

class LoginModelData {
    String accessToken;
    String token;
    int passwordRemaining;

    LoginModelData({
        required this.accessToken,
        required this.token,
        required this.passwordRemaining,
    });

    factory LoginModelData.fromJson(Map<String, dynamic> json) => LoginModelData(
        accessToken: json["accessToken"],
        token: json["token"],
        passwordRemaining: json["password_remaining"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "token": token,
        "password_remaining": passwordRemaining,
    };
}
