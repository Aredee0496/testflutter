// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  int code;
  String result;
  String message;
  List<DataMenu> data;

  MenuModel({
    required this.code,
    required this.result,
    required this.message,
    required this.data,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        data:
            List<DataMenu>.from(json["data"].map((x) => DataMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataMenu {
  int id;
  int applicationId;
  String applicationName;
  String applicationNameAlt;
  int roleId;
  String roleName;
  String roleNameAlt;
  List<Permission> permission;
  String? createdBy;
  String? updatedBy;

  DataMenu({
    required this.id,
    required this.applicationId,
    required this.applicationName,
    required this.applicationNameAlt,
    required this.roleId,
    required this.roleName,
    required this.roleNameAlt,
    required this.permission,
    this.createdBy,
    this.updatedBy,
  });

  factory DataMenu.fromJson(Map<String, dynamic> json) => DataMenu(
        id: json["Id"],
        applicationId: json["ApplicationId"],
        applicationName: json["ApplicationName"],
        applicationNameAlt: json["ApplicationName_Alt"],
        roleId: json["RoleId"],
        roleName: json["RoleName"],
        roleNameAlt: json["RoleName_Alt"],
        permission: List<Permission>.from(
            json["Permission"].map((x) => Permission.fromJson(x))),
        createdBy: json["CreatedBy"],
        updatedBy: json["UpdatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ApplicationId": applicationId,
        "ApplicationName": applicationName,
        "ApplicationName_Alt": applicationNameAlt,
        "RoleId": roleId,
        "RoleName": roleName,
        "RoleName_Alt": roleNameAlt,
        "Permission": List<dynamic>.from(permission.map((x) => x.toJson())),
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
      };
}

class Permission {
  int menuId;
  String menuName;
  String menuNameAlt;
  String pathUrl;
  String icon;
  bool noti;
  List<Action> actions;

  Permission({
    required this.menuId,
    required this.menuName,
    required this.menuNameAlt,
    required this.pathUrl,
    required this.icon,
    required this.noti,
    required this.actions,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        menuId: json["MenuId"],
        menuName: json["MenuName"],
        menuNameAlt: json["MenuName_Alt"],
        pathUrl: json["PathURL"],
        icon: json["Icon"],
        noti: false,
        actions:
            List<Action>.from(json["Actions"].map((x) => Action.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MenuId": menuId,
        "MenuName": menuName,
        "MenuName_Alt": menuNameAlt,
        "PathURL": pathUrl,
        "Icon": icon,
        "Actions": List<dynamic>.from(actions.map((x) => x.toJson())),
      };
}

class Action {
  int permissionId;
  String permissionName;
  String permissionNameAlt;

  Action({
    required this.permissionId,
    required this.permissionName,
    required this.permissionNameAlt,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        permissionId: json["PermissionId"],
        permissionName: json["PermissionName"],
        permissionNameAlt: json["PermissionName_Alt"],
      );

  Map<String, dynamic> toJson() => {
        "PermissionId": permissionId,
        "PermissionName": permissionName,
        "PermissionName_Alt": permissionNameAlt,
      };
}
