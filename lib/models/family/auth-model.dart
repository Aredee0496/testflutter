// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  int code;
  String result;
  String message;
  Data data;

  AuthModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
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
  String? accesstoken;
  String? refreshtoken;
  User? user;
  List<Role>? role;
  List<MsEmployee>? msEmployee;

  Data(
      {this.accesstoken,
      this.refreshtoken,
      this.user,
      this.role,
      this.msEmployee});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accesstoken: json["accesstoken"],
        // refreshtoken: json["refreshtoken"],
        refreshtoken: json["refreshtokenmobile"],
        user: User.fromJson(json["user"]),
        role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
        msEmployee: List<MsEmployee>.from(
            json["MSEmployee"].map((x) => MsEmployee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "accesstoken": accesstoken,
        "refreshtoken": refreshtoken,
        "user": user?.toJson(),
        "role": List<dynamic>.from(role!.map((x) => x.toJson())),
        "MSEmployee": List<dynamic>.from(msEmployee!.map((x) => x.toJson())),
      };
}

class MsEmployee {
  String userLogin;
    String employeeCode;
    String employeeTitle;
    String employeeFirstName;
    String employeeLastName;
    String employeeTitleAlt;
    String employeeFirstNameAlt;
    String employeeLastNameAlt;
    String employeeName;
    String employeeNameAlt;
    String positionName;
    String positionNameAlt;
    String departmentName;
    String departmentNameAlt;
    String divisionName;
    String divisionNameAlt;
    String companyCode;
    String companyName;
    String companyAlt;
    String plantCode;
    String plantName;
    String plantNameAlt;
    String employeeEmail1;
    String employeeUserName;
    String employeeNickname;
    String employeeTelephone1;
    String employeeWorkStatus;

  MsEmployee({
    required this.userLogin,
        required this.employeeCode,
        required this.employeeTitle,
        required this.employeeFirstName,
        required this.employeeLastName,
        required this.employeeTitleAlt,
        required this.employeeFirstNameAlt,
        required this.employeeLastNameAlt,
        required this.employeeName,
        required this.employeeNameAlt,
        required this.positionName,
        required this.positionNameAlt,
        required this.departmentName,
        required this.departmentNameAlt,
        required this.divisionName,
        required this.divisionNameAlt,
        required this.companyCode,
        required this.companyName,
        required this.companyAlt,
        required this.plantCode,
        required this.plantName,
        required this.plantNameAlt,
        required this.employeeEmail1,
        required this.employeeUserName,
        required this.employeeNickname,
        required this.employeeTelephone1,
        required this.employeeWorkStatus,
  });

  factory MsEmployee.fromJson(Map<String, dynamic> json) => MsEmployee(
        userLogin: json["UserLogin"] ?? '',
    employeeCode: json["EmployeeCode"] ?? '',
    employeeTitle: json["EmployeeTitle"] ?? '',
    employeeFirstName: json["EmployeeFirstName"] ?? '',
    employeeLastName: json["EmployeeLastName"] ?? '',
    employeeTitleAlt: json["EmployeeTitle_Alt"] ?? '',
    employeeFirstNameAlt: json["EmployeeFirstName_Alt"] ?? '',
    employeeLastNameAlt: json["EmployeeLastName_Alt"] ?? '',
    employeeName: json["EmployeeName"] ?? '',
    employeeNameAlt: json["EmployeeNameAlt"] ?? '',
    positionName: json["PositionName"] ?? '',
    positionNameAlt: json["PositionNameAlt"] ?? '',
    departmentName: json["DepartmentName"] ?? '',
    departmentNameAlt: json["DepartmentNameAlt"] ?? '',
    divisionName: json["DivisionName"] ?? '',
    divisionNameAlt: json["DivisionNameAlt"] ?? '',
    companyCode: json["CompanyCode"] ?? '',
    companyName: json["CompanyName"] ?? '',
    companyAlt: json["CompanyAlt"] ?? '',
    plantCode: json["PlantCode"] ?? '',
    plantName: json["PlantName"] ?? '',
    plantNameAlt: json["PlantNameAlt"] ?? '',
    employeeEmail1: json["EmployeeEmail1"] ?? '',
    employeeUserName: json["EmployeeUserName"] ?? '',
    employeeNickname: json["EmployeeNickname"] ?? '',
    employeeTelephone1: json["EmployeeTelephone1"] ?? '',
    employeeWorkStatus: json["EmployeeWorkStatus"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "UserLogin": userLogin.isNotEmpty ? userLogin : null,
    "EmployeeCode": employeeCode.isNotEmpty ? employeeCode : null,
    "EmployeeTitle": employeeTitle.isNotEmpty ? employeeTitle : null,
    "EmployeeFirstName": employeeFirstName.isNotEmpty ? employeeFirstName : null,
    "EmployeeLastName": employeeLastName.isNotEmpty ? employeeLastName : null,
    "EmployeeTitle_Alt": employeeTitleAlt.isNotEmpty ? employeeTitleAlt : null,
    "EmployeeFirstName_Alt": employeeFirstNameAlt.isNotEmpty ? employeeFirstNameAlt : null,
    "EmployeeLastName_Alt": employeeLastNameAlt.isNotEmpty ? employeeLastNameAlt : null,
    "EmployeeName": employeeName.isNotEmpty ? employeeName : null,
    "EmployeeNameAlt": employeeNameAlt.isNotEmpty ? employeeNameAlt : null,
    "PositionName": positionName.isNotEmpty ? positionName : null,
    "PositionNameAlt": positionNameAlt.isNotEmpty ? positionNameAlt : null,
    "DepartmentName": departmentName.isNotEmpty ? departmentName : null,
    "DepartmentNameAlt": departmentNameAlt.isNotEmpty ? departmentNameAlt : null,
    "DivisionName": divisionName.isNotEmpty ? divisionName : null,
    "DivisionNameAlt": divisionNameAlt.isNotEmpty ? divisionNameAlt : null,
    "CompanyCode": companyCode.isNotEmpty ? companyCode : null,
    "CompanyName": companyName.isNotEmpty ? companyName : null,
    "CompanyAlt": companyAlt.isNotEmpty ? companyAlt : null,
    "PlantCode": plantCode.isNotEmpty ? plantCode : null,
    "PlantName": plantName.isNotEmpty ? plantName : null,
    "PlantNameAlt": plantNameAlt.isNotEmpty ? plantNameAlt : null,
    "EmployeeEmail1": employeeEmail1.isNotEmpty ? employeeEmail1 : null,
    "EmployeeUserName": employeeUserName.isNotEmpty ? employeeUserName : null,
    "EmployeeNickname": employeeNickname.isNotEmpty ? employeeNickname : null,
    "EmployeeTelephone1": employeeTelephone1.isNotEmpty ? employeeTelephone1 : null,
    "EmployeeWorkStatus": employeeWorkStatus.isNotEmpty ? employeeWorkStatus : null,
      };
}

class Role {
  int? applicationId;
  String? applicationName;
  String? applicationNameAlt;
  int? roleId;
  String? roleName;
  String? roleNameAlt;
  List<PlantCode>? plantCode;

  Role({
    this.applicationId,
    this.applicationName,
    this.applicationNameAlt,
    this.roleId,
    this.roleName,
    this.roleNameAlt,
    this.plantCode,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        applicationId: json["ApplicationId"],
        applicationName: json["ApplicationName"],
        applicationNameAlt: json["ApplicationName_Alt"],
        roleId: json["RoleId"],
        roleName: json["RoleName"],
        roleNameAlt: json["RoleName_Alt"],
        plantCode: List<PlantCode>.from(
            json["PlantCode"].map((x) => PlantCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ApplicationId": applicationId,
        "ApplicationName": applicationName,
        "ApplicationName_Alt": applicationNameAlt,
        "RoleId": roleId,
        "RoleName": roleName,
        "RoleName_Alt": roleNameAlt,
        "PlantCode": List<dynamic>.from(plantCode!.map((x) => x.toJson())),
      };
}

class PlantCode {
  String? plantCode;
  String? plantName;
  String? plantNameAlt;

  PlantCode({
    this.plantCode,
    this.plantName,
    this.plantNameAlt,
  });

  factory PlantCode.fromJson(Map<String, dynamic> json) => PlantCode(
        plantCode: json["PlantCode"],
        plantName: json["PlantName"],
        plantNameAlt: json["PlantName_Alt"],
      );

  Map<String, dynamic> toJson() => {
        "PlantCode": plantCode,
        "PlantName": plantName,
        "PlantName_Alt": plantNameAlt,
      };
}

class User {
  String? userLogin;
  String? employeeCode;
  String? employeeTitle;
  String? employeeFirstName;
  String? employeeLastName;
  String? employeeTitleAlt;
  String? employeeFirstNameAlt;
  String? employeeLastNameAlt;
  String? employeeNickname;
  String? employeeName;
  String? employeeNameAlt;
  String? position;
  String? positionName;
  String? positionNameAlt;
  String? departmentCode;
  String? departmentName;
  String? departmentNameAlt;
  String? divisionCode;
  String? divisionName;
  String? divisionNameAlt;
  String? companyCode;
  String? companyName;
  String? companyAlt;
  String? plantCode;
  String? plantName;
  String? plantNameAlt;
  String? branchCode;
  String? branchName;
  String? branchNamehAlt;
  String? employeeEmail1;
  String? employeeEmail2;
  String? employeeAddress;
  String? employeeAddressAlt;
  String? employeeAddress2;
  String? employeeAddress2Alt;
  String? employeeDistrict;
  String? employeeCity;
  String? employeeProvince;
  String? employeePostcode;
  String? employeeCountry;
  String? employeeTelephone1;
  String? employeeTelephone2;
  String? employeeEstAddress1;
  String? employeeEstAddress2;
  String? employeeEstPostCode;
  String? employeeEmploymentTypeAlt;
  String? employeePayTypeAlt;
  String? employeePayType;
  String? employeeWorkStatus;
  String? employeeEndJobDate;
  int? defaultApplicationId;
  int? defaultRoleId;
  // int? userStatus;

  User({
    this.userLogin,
    this.employeeCode,
    this.employeeTitle,
    this.employeeFirstName,
    this.employeeLastName,
    this.employeeTitleAlt,
    this.employeeFirstNameAlt,
    this.employeeLastNameAlt,
    this.employeeNickname,
    this.employeeName,
    this.employeeNameAlt,
    this.position,
    this.positionName,
    this.positionNameAlt,
    this.departmentCode,
    this.departmentName,
    this.departmentNameAlt,
    this.divisionCode,
    this.divisionName,
    this.divisionNameAlt,
    this.companyCode,
    this.companyName,
    this.companyAlt,
    this.plantCode,
    this.plantName,
    this.plantNameAlt,
    this.branchCode,
    this.branchName,
    this.branchNamehAlt,
    this.employeeEmail1,
    this.employeeEmail2,
    this.employeeAddress,
    this.employeeAddressAlt,
    this.employeeAddress2,
    this.employeeAddress2Alt,
    this.employeeDistrict,
    this.employeeCity,
    this.employeeProvince,
    this.employeePostcode,
    this.employeeCountry,
    this.employeeTelephone1,
    this.employeeTelephone2,
    this.employeeEstAddress1,
    this.employeeEstAddress2,
    this.employeeEstPostCode,
    this.employeeEmploymentTypeAlt,
    this.employeePayTypeAlt,
    this.employeePayType,
    this.employeeWorkStatus,
    this.employeeEndJobDate,
    this.defaultApplicationId,
    this.defaultRoleId,
    // this.userStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userLogin: json["UserLogin"],
        employeeCode: json["EmployeeCode"],
        employeeTitle: json["EmployeeTitle"],
        employeeFirstName: json["EmployeeFirstName"],
        employeeLastName: json["EmployeeLastName"],
        employeeTitleAlt: json["EmployeeTitle_Alt"],
        employeeFirstNameAlt: json["EmployeeFirstName_Alt"],
        employeeLastNameAlt: json["EmployeeLastName_Alt"],
        employeeNickname: json["EmployeeNickname"],
        employeeName: json["EmployeeName"],
        employeeNameAlt: json["EmployeeNameAlt"],
        position: json["Position"],
        positionName: json["PositionName"],
        positionNameAlt: json["PositionNameAlt"],
        departmentCode: json["DepartmentCode"],
        departmentName: json["DepartmentName"],
        departmentNameAlt: json["DepartmentNameAlt"],
        divisionCode: json["DivisionCode"],
        divisionName: json["DivisionName"],
        divisionNameAlt: json["DivisionNameAlt"],
        companyCode: json["CompanyCode"],
        companyName: json["CompanyName"],
        companyAlt: json["CompanyAlt"],
        plantCode: json["PlantCode"],
        plantName: json["PlantName"],
        plantNameAlt: json["PlantNameAlt"],
        branchCode: json["BranchCode"],
        branchName: json["BranchName"],
        branchNamehAlt: json["BranchNamehAlt"],
        employeeEmail1: json["EmployeeEmail1"],
        employeeEmail2: json["EmployeeEmail2"],
        employeeAddress: json["EmployeeAddress"],
        employeeAddressAlt: json["EmployeeAddress_Alt"],
        employeeAddress2: json["EmployeeAddress2"],
        employeeAddress2Alt: json["EmployeeAddress2_Alt"],
        employeeDistrict: json["EmployeeDistrict"],
        employeeCity: json["EmployeeCity"],
        employeeProvince: json["EmployeeProvince"],
        employeePostcode: json["EmployeePostcode"],
        employeeCountry: json["EmployeeCountry"],
        employeeTelephone1: json["EmployeeTelephone1"],
        employeeTelephone2: json["EmployeeTelephone2"],
        employeeEstAddress1: json["EmployeeEstAddress1"],
        employeeEstAddress2: json["EmployeeEstAddress2"],
        employeeEstPostCode: json["EmployeeEstPostCode"],
        employeeEmploymentTypeAlt: json["EmployeeEmploymentType_Alt"],
        employeePayTypeAlt: json["EmployeePayType_Alt"],
        employeePayType: json["EmployeePayType"],
        employeeWorkStatus: json["EmployeeWorkStatus"],
        employeeEndJobDate: json["EmployeeEndJobDate"],
        defaultApplicationId: json["DefaultApplicationId"],
        defaultRoleId: json["DefaultRoleId"],
        // userStatus: json["UserStatus"],
      );

  Map<String, dynamic> toJson() => {
        "UserLogin": userLogin,
        "EmployeeCode": employeeCode,
        "EmployeeTitle": employeeTitle,
        "EmployeeFirstName": employeeFirstName,
        "EmployeeLastName": employeeLastName,
        "EmployeeTitle_Alt": employeeTitleAlt,
        "EmployeeFirstName_Alt": employeeFirstNameAlt,
        "EmployeeLastName_Alt": employeeLastNameAlt,
        "EmployeeNickname": employeeNickname,
        "EmployeeName": employeeName,
        "EmployeeNameAlt": employeeNameAlt,
        "Position": position,
        "PositionName": positionName,
        "PositionNameAlt": positionNameAlt,
        "DepartmentCode": departmentCode,
        "DepartmentName": departmentName,
        "DepartmentNameAlt": departmentNameAlt,
        "DivisionCode": divisionCode,
        "DivisionName": divisionName,
        "DivisionNameAlt": divisionNameAlt,
        "CompanyCode": companyCode,
        "CompanyName": companyName,
        "CompanyAlt": companyAlt,
        "PlantCode": plantCode,
        "PlantName": plantName,
        "PlantNameAlt": plantNameAlt,
        "BranchCode": branchCode,
        "BranchName": branchName,
        "BranchNamehAlt": branchNamehAlt,
        "EmployeeEmail1": employeeEmail1,
        "EmployeeEmail2": employeeEmail2,
        "EmployeeAddress": employeeAddress,
        "EmployeeAddress_Alt": employeeAddressAlt,
        "EmployeeAddress2": employeeAddress2,
        "EmployeeAddress2_Alt": employeeAddress2Alt,
        "EmployeeDistrict": employeeDistrict,
        "EmployeeCity": employeeCity,
        "EmployeeProvince": employeeProvince,
        "EmployeePostcode": employeePostcode,
        "EmployeeCountry": employeeCountry,
        "EmployeeTelephone1": employeeTelephone1,
        "EmployeeTelephone2": employeeTelephone2,
        "EmployeeEstAddress1": employeeEstAddress1,
        "EmployeeEstAddress2": employeeEstAddress2,
        "EmployeeEstPostCode": employeeEstPostCode,
        "EmployeeEmploymentType_Alt": employeeEmploymentTypeAlt,
        "EmployeePayType_Alt": employeePayTypeAlt,
        "EmployeePayType": employeePayType,
        "EmployeeWorkStatus": employeeWorkStatus,
        "EmployeeEndJobDate": employeeEndJobDate,
        "DefaultApplicationId": defaultApplicationId,
        "DefaultRoleId": defaultRoleId,
        // "UserStatus": userStatus,
      };
}
