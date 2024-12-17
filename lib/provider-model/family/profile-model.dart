import 'dart:convert';

List<MsEmployee> msEmployeeFromJson(String str) => List<MsEmployee>.from(json.decode(str).map((x) => MsEmployee.fromJson(x)));

String msEmployeeToJson(List<MsEmployee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  // การจัดการกับค่า null ใน toJson
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