import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/family/auth-model.dart';
import 'package:starlightserviceapp/pages/login3.dart';
import 'package:starlightserviceapp/provider-model/setting_model.dart';
import 'package:starlightserviceapp/services/app/notifications-service.dart';
import 'package:starlightserviceapp/services/family-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String msgVerify = "";
  bool loading = false;
  FamilyService familyService = FamilyService();
  StorageApp storageApp = StorageApp();

  String errMessage = "";

  openLogin(String url, String token, String pageReDirect) {
    print('url: $url === token: $token');
    setState(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage()),
          (route) => false);
    });
  }

  refreshLogin() {
    setState(() {
      verifyId();
    });
  }

  verifyAuth(data) async {
    try {
      final response = await familyService.loginMobile2(context, data);
      if (response.result == "success") {
        Role checkRole = await storageApp.getRole();
        if (checkRole.roleId == ROLEDRIVERID ||
            checkRole.roleId == ROLETANKID) {
          // if (checkRole.plantCode!.length > 1) {
          //   DialogHelper.hideLoading(context);
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => const PlantPage()),
          //       (route) => false);
          // } else {
          setState(() {
            msgVerify = "Setting Notificaations...";
          });
          await PushNotifications().saveTokenNoti(context);
          DialogHelper.hideLoading(context);
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', (Route<dynamic> route) => false);
          // final processNoti = await PushNotifications().saveTokenNoti(context);
          // if (processNoti == "") {
          //   DialogHelper.hideLoading(context);
          //   Navigator.pushNamedAndRemoveUntil(
          //       context, '/home', (Route<dynamic> route) => false);
          // } else {
          //   setState(() {
          //     loading = false;
          //     errMessage = "$processNoti";
          //   });
          //   // }
          // }
        } else {
          setState(() {
            loading = false;
            errMessage =
                "This user does not have a role driver in the system.\nPlease contact the administrator";
          });
        }
      } else {
        print(response.message);
        setState(() {
          loading = false;
          errMessage = response.message;
        });
      }
    } catch (e) {
      print("$e");
      setState(() {
        loading = false;
        errMessage = "$e";
      });
    }
  }

  verifyId() async {
    StorageApp _storageApp = StorageApp();
    final settings = Provider.of<SettingsModel>(context, listen: false);
    try {
      setState(() {
        errMessage = "";
        msgVerify = "Verify identity...";
        loading = true;
      });
      final checkAuth = await _storageApp.getAuthenticated();
      if (checkAuth) {
        if (settings.isBiometricEnabled) {
          bool isAuthenticated = await settings.authenticateUser();
          if (isAuthenticated) {
            setState(() {
              loading = false;
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            });
          }
        } else {
          setState(() {
            loading = false;
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (Route<dynamic> route) => false);
          });
        }
      } else {
        final data = await familyService.validateId(context);
        print(data);
        if (data != null) {
          if (data.token != "" && data.accessToken != "") {
            setState(() {
              msgVerify = "Verify authentication...";
              verifyAuth(data.dataSTAOAuth);
            });
          } else {
            setState(() {
              msgVerify = "opening login...";
            });
            openLogin(
                data.urloAuth ?? "", data.id ?? "", data.pageReDirect ?? "");
          }
        } else {
          setState(() {
            loading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    verifyId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().primary(),
      body: Center(
        child: Card(
          surfaceTintColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images-sritrang/favicon.png",
                  ),
                  const Text(
                    "MOBILE MANAGEMENT",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    APPNAME,
                    style: TextStyle(fontSize: 24),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  if (errMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errMessage,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  if (loading)
                    Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: MyColors().primary(),
                      ),
                    ),
                  if (loading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        msgVerify,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  else
                    OutlinedButton(
                        onPressed: () {
                          refreshLogin();
                        },
                        style: MyStyle().outlinedButton(MyColors().primary()),
                        child: const Text(
                          "Try again",
                          style: TextStyle(fontSize: 18),
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
