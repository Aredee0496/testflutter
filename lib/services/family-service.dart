import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/family/auth-model.dart';
import 'package:starlightserviceapp/models/family/auth-model.dart' as dataAuth;
import 'package:starlightserviceapp/models/family/id-model.dart';
import 'package:starlightserviceapp/models/family/menu-model.dart';
import 'package:starlightserviceapp/models/family/profile-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/models/family/switch-plant.dart';
import 'package:starlightserviceapp/services/app-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';
import 'package:starlightserviceapp/provider-model/profile_model.dart';

class FamilyService {
  Future<ResponseModel> loginMobile2(
      BuildContext context, dataAuth.Data dataAuth) async {
    StorageApp storageApp = StorageApp();
    final data = dataAuth;
    final accessToken = data.accesstoken ?? "";
    print("refreshtokenmobile => ${data.refreshtoken}");
    // final refreshToken = data.refreshtoken ?? "";
    final user = data.user;
    if (user != null) {
      // if (user.userStatus != 0) {
      context.read<ProfileModel>().addprofile(user.employeeNameAlt ?? "");
      final role = data.role;
      await storageApp.setUser(user);
      await storageApp.setAuth(true);
      final employee = data.msEmployee;

      List<MsEmployee> employees = employee ?? [];

      Provider.of<ProfileModel2>(context, listen: false).setProfile(employees);

      if (employee != null) {
        if (employee.isNotEmpty) {}
      }
      storageApp.clearRole();

      //Role
      if (role != null) {
        if (role.isNotEmpty) {
          List<Role> itemsRole = [];
          for (var item in role) {
            if (item.applicationId == APPLICATIONID &&
                item.roleId != ROLEMANAGEMENTID) {
              itemsRole.add(item);
            }
          }
          if (itemsRole.isNotEmpty) {
            final tempRole = itemsRole
                .where((element) =>
                    element.applicationId == user.defaultApplicationId &&
                    (element.roleId == ROLEDRIVERID ||
                        element.roleId == ROLETANKID))
                .toList();
            if (tempRole.isNotEmpty) {
              await getDataMenu(context, accessToken,
                  tempRole[0].applicationId ?? 0, tempRole[0].roleId ?? 0);
              if (tempRole[0].plantCode != null) {
                if (tempRole[0].plantCode!.isNotEmpty) {
                  try {
                    if (tempRole[0].plantCode!.length > 0) {
                      //   await storageApp.setRole(tempRole[0]);
                      //   return ResponseModel(
                      //       code: 200, result: "success", message: "");
                      // } else {
                      String plantcode =
                          tempRole[0].plantCode![0].plantCode ?? "";
                      ResponseModel responseModelToken =
                          await switchPlant(context, plantcode, accessToken);
                      if (responseModelToken.result == "success") {
                        await storageApp.setRole(tempRole[0]);
                        await storageApp.setPlant(plantcode);
                        return responseModelToken;
                      } else {
                        return throw (responseModelToken.message);
                      }
                    } else {
                      return throw ("There is no plant in the system.");
                    }
                  } catch (e) {
                    return throw ("$e");
                  }
                } else {
                  return throw ("There is no plant in the system.");
                }
              } else {
                return throw ("There is no plant in the system.");
              }
            } else {
              return throw ("There is no Role in the system.");
            }
          } else {
            return throw ("There is no Role in the system.");
          }
        } else {
          return throw ("There is no Role in the system.");
        }
      } else {
        return throw ("There is no role in the system.");
      }
      // } else {
      //   return throw ("This user is disabled.");
      // }
    } else {
      return throw ("There is no user information.");
    }
  }

  Future<ResponseModel> loginMobile(
      BuildContext context, String token, String acctoken) async {
    StorageApp storageApp = StorageApp();
    try {
      final url = Uri.https(URL_API_APP, "$VERSION_API_APP/sylogin/auth");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      final body = {"accesstoken": acctoken};
      final response =
          await post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        AuthModel res = AuthModel.fromJson(jsonDecode(response.body));
        if (res.code == 200) {
          if (res.result == 'success') {
            final data = res.data;
            final accessToken = data.accesstoken ?? "";
            // final refreshToken = data.refreshtoken ?? "";
            final user = data.user;
            if (user != null) {
              // if (user.userStatus != 0) {
              context
                  .read<ProfileModel>()
                  .addprofile(user.employeeNameAlt ?? "");
              final role = data.role;
              await storageApp.setUser(user);
              await storageApp.setAuth(true);
              final employee = data.msEmployee;
              if (employee != null) {
                if (employee.isNotEmpty) {}
              }
              storageApp.clearRole();

              //Role
              if (role != null) {
                if (role.isNotEmpty) {
                  List<Role> itemsRole = [];
                  for (var item in role) {
                    if (item.applicationId == APPLICATIONID &&
                        item.roleId != ROLEMANAGEMENTID) {
                      itemsRole.add(item);
                    }
                  }
                  if (itemsRole.isNotEmpty) {
                    final tempRole = itemsRole
                        .where((element) =>
                            element.applicationId ==
                                user.defaultApplicationId &&
                            (element.roleId == ROLEDRIVERID ||
                                element.roleId == ROLETANKID))
                        .toList();
                    if (tempRole.isNotEmpty) {
                      await getDataMenu(
                          context,
                          accessToken,
                          tempRole[0].applicationId ?? 0,
                          tempRole[0].roleId ?? 0);
                      if (tempRole[0].plantCode != null) {
                        if (tempRole[0].plantCode!.isNotEmpty) {
                          try {
                            if (tempRole[0].plantCode!.length > 1) {
                              await storageApp.setRole(tempRole[0]);
                              return ResponseModel(
                                  code: res.code,
                                  result: res.result,
                                  message: res.message);
                            } else {
                              String plantcode =
                                  tempRole[0].plantCode![0].plantCode ?? "";
                              ResponseModel responseModelToken =
                                  await switchPlant(
                                      context, plantcode, accessToken);
                              if (responseModelToken.result == "success") {
                                await storageApp.setRole(tempRole[0]);
                                await storageApp.setPlant(plantcode);
                                return responseModelToken;
                              } else {
                                return throw (responseModelToken.message);
                              }
                            }
                          } catch (e) {
                            return throw ("$e");
                          }
                        } else {
                          return throw ("There is no plant in the system.");
                        }
                      } else {
                        return throw ("There is no plant in the system.");
                      }
                    } else {
                      return throw ("There is no Role in the system.");
                    }
                  } else {
                    return throw ("There is no Role in the system.");
                  }
                } else {
                  return throw ("There is no Role in the system.");
                }
              } else {
                return throw ("There is no role in the system.");
              }
              // } else {
              //   return throw ("This user is disabled.");
              // }
            } else {
              return throw ("There is no user information.");
            }
          } else {
            return throw (res.message);
          }
        } else {
          return throw (res.message);
        }
      } else {
        try {
          ResponseModel data =
              ResponseModel.fromJson(jsonDecode(response.body));
          return throw (data.message);
        } catch (e) {
          if (response.statusCode == 503 || response.statusCode == 502) {
            // return throw ("503 Service Temporarily Unavailable");
            return throw ("${response.statusCode}: ${response.reasonPhrase}");
          } else {
            return throw ("$e");
          }
        }
      }
    } catch (e) {
      return throw ("$e");
    }
  }

  getDataMenu(BuildContext context, String token, int appid, int roleid) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/sylogin/getpermission/");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      final body = {"ApplicationId": appid, "RoleId": roleid};
      final response =
          await post(url, headers: headers, body: json.encode(body));
      print('dedededeeedddd');
      if (response.statusCode == 200) {
        print("${jsonDecode(response.body)}");
        final data = MenuModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            final temp = data.data;
            if (temp.isNotEmpty) {
              temp[0].permission.add(temp[0].permission[1]);
              storageApp.setMenu(temp[0]);

              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              print(
                  'Menu saved to SharedPreferences: ${prefs.getString("menu-${appid}")}');
            }
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return getDataMenu(context, token, appid, roleid);
          } else {
            return throw ("Token Expired");
          }
        } else {
          return throw (data.message);
        }
      } else {
        try {
          ResponseModel data =
              ResponseModel.fromJson(jsonDecode(response.body));
          return throw (data.message);
        } catch (e) {
          if (response.statusCode == 503 || response.statusCode == 502) {
            // return throw ("503 Service Temporarily Unavailable");
            return throw ("${response.statusCode}: ${response.reasonPhrase}");
          } else {
            return throw ("$e");
          }
        }
      }
    } catch (e) {
      return throw ("$e");
    }
  }

  switchPlant(BuildContext context, String plant, String token) async {
    StorageApp storageApp = StorageApp();
    AppService appService = AppService();
    try {
      print(plant);
      final url = Uri.https(URL_API_APP, "$VERSION_API_APP/switchplant/$plant");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await get(url, headers: headers);
      if (appService.checkExpired(response.statusCode)) {
        final res = await appService.generateAccessToken(context);
        if (res != null) {
          return switchPlant(context, plant, token);
        } else {
          return throw ("Token Expired");
        }
      } else if (response.statusCode == 200) {
        final data = SwitchPlantModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            await storageApp.setAccessToken(data.data.accesstoken);
            await storageApp.setRefreshToken(data.data.refreshtoken);

            ResponseModel responseModel = ResponseModel(
                code: data.code, result: data.result, message: data.message);
            return responseModel;
          } else {
            return throw (data.message);
          }
        } else if (appService.checkExpired(data.code)) {
          final res = await appService.generateAccessToken(context);
          if (res != null) {
            return switchPlant(context, plant, token);
          } else {
            return throw ("Token Expired");
          }
        } else {
          return throw (data.message);
        }
      } else {
        try {
          ResponseModel data =
              ResponseModel.fromJson(jsonDecode(response.body));
          return throw (data.message);
        } catch (e) {
          if (response.statusCode == 503 || response.statusCode == 502) {
            // return throw ("503 Service Temporarily Unavailable");
            return throw ("${response.statusCode}: ${response.reasonPhrase}");
          } else {
            return throw ("$e");
          }
        }
      }
    } catch (e) {
      return throw ("$e");
    }
  }

  validateId(BuildContext context) async {
    StorageApp storageApp = StorageApp();
    try {
      final id = await storageApp.getIdApp();
      final url = Uri.https(URL_API_APP, "v2/sylogin/loginoauthload/");
      final headers = {
        "Content-Type": "application/json",
      };
      final body = {"IndexRedirect": INDEXREDIRECT, "Id": id};
      final response =
          await post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        final data = IdModel.fromJson(jsonDecode(response.body));
        if (data.code == 200) {
          if (data.result == 'success') {
            final temp = data.data;
            print("validateId temp.id: ${temp.id}");
            await storageApp.setIdApp(temp.id ?? "");
            return temp;
          }
        }
      } else {
        print(response.statusCode);
      }
      return null;
    } catch (e) {
      print("error=> $e");
      return null;
    }
  }

  onLogout() async {
    try {
      StorageApp storageApp = StorageApp();
      String token = await storageApp.getAccessToken();

      final url = Uri.https(URL_API_APP, "$VERSION_API_APP/sylogin/signout");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      await get(url, headers: headers);
    } catch (e) {
      print("$e");
    }
  }

  gotoProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  gotoSetting(BuildContext context) {
    Navigator.pushNamed(context, '/setting');
  }

  logout(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return dialogConfirm(context, "Logout?", "Do you want logout");
        }).then((value) async {
      if (value == true) {
        print("logout");
        await onLogout();
        await StorageApp().clearAll(); 
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    });
  }
}
