import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/app/menu-noti-model.dart';
import 'package:starlightserviceapp/models/family/menu-model.dart';
import 'package:starlightserviceapp/pages/home/widget/profile.dart';
import 'package:starlightserviceapp/provider-model/profile_model.dart';
import 'package:starlightserviceapp/services/app-service.dart';
import 'package:starlightserviceapp/services/family-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:badges/badges.dart' as badges;
import 'package:starlightserviceapp/widgets/background.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";
  List<Permission> menuAll = [];
  // List<Permission> menu = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initApp();
      Provider.of<ProfileModel2>(context, listen: false)
          .loadFromSharedPreferences();
    });
    super.initState();
  }

  initApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      // appName = packageInfo.appName;
      // packageName = packageInfo.packageName;
      version = packageInfo.version;
      // buildNumber = packageInfo.buildNumber;
    });

    final auth = await StorageApp().getAuth();
    log("$auth", name: "check auth");
    if (auth == false) {
      AppService().logout(context);
    }

    Map? payload;
    int id = 578;

    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      payload = data.data;
    }
    // for foreground state
    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }

    if (payload != null) {
      id = int.parse(payload["MenuId"]);
    }
    await getMenu(id);
  }

  onLogout() async {
    await FamilyService().logout(context);
  }

  gotoSetting() async {
    await FamilyService().gotoSetting(context);
  }

  gotoProfile() async {
    await FamilyService().gotoProfile(context);
  }

  getMenu(int id) async {
    StorageApp storageApp = StorageApp();
    DataMenu dataMenu = await storageApp.getMenu();
    List<Permission> tempmenu = [];
    if (dataMenu.permission.isNotEmpty) {
      var temp = dataMenu.permission;
      for (var i = 0; i < temp.length; i++) {
        final index =
            MENUIDOFDRIVERID.indexWhere((item) => item == temp[i].menuId);
        if (index != -1) {
          if (temp[i].menuId == id) {
            temp[i].noti = true;
          }
          tempmenu.add(temp[i]);
        }
        final indexStaff =
            MENUIDOFSTAFF.indexWhere((item) => item == temp[i].menuId);
        if (indexStaff != -1) {
          if (temp[i].menuId == id) {
            temp[i].noti = true;
          }
          tempmenu.add(temp[i]);
        }
      }
    }
    context.read<MenuNotiModel>().menu = tempmenu;
  }

  onClickMenu(Permission tempMenu, int index) {
    try {
      context.read<MenuNotiModel>().updateRemoveNotiMenuId(tempMenu.menuId);
      Navigator.pushNamed(context, tempMenu.pathUrl,
          arguments: {"titlePage": tempMenu.menuName});
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuNotiModel = context.watch<MenuNotiModel>();
    return Stack(
      children: [
        const MyBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "STL Connect",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(
                "assets/images-sritrang/favicon.png",
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                child: Consumer<ProfileModel2>(
                  builder: (context, profileModel2, child) {
                    return Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 1,
                              color: Colors.grey,
                              spreadRadius: 1)
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: profileModel2.profileImage != null
                            ? MemoryImage(profileModel2.profileImage!)
                            : null,
                        child: profileModel2.profileImage == null
                            ? Image.asset(
                                "assets/images/person.png",
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    );
                  },
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: "profile",
                    onTap: () => gotoProfile(),
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.person, color: MyColors().primary()),
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 15, color: MyColors().primary()),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () => gotoSetting(),
                    value: "setting",
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.settings, color: MyColors().primary()),
                      title: Text('Setting',
                          style: TextStyle(
                            fontSize: 15, color: MyColors().primary()),),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () => onLogout(),
                    value: "logout",
                    child: const ListTile(
                      dense: true,
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Logout',
                          style: TextStyle(fontSize: 15, color: Colors.red)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
  child: Column(
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: ProfileHome(),
      ),
      menuNotiModel.menu.isEmpty
          ? const Center(
              child: Text("Can't find Menu"),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,  // Allow GridView to take up only necessary space
                primary: false,  // Prevent scrolling conflicts with SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(),  // Disable scrolling of GridView
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: menuNotiModel.menu.length,
                itemBuilder: (context, index) {
                  final e = menuNotiModel.menu[index];
                  return InkWell(
                    onTap: () {
                      onClickMenu(e, index);
                    },
                    child: e.noti == true
                        ? badges.Badge(
                            position: badges.BadgePosition.topEnd(
                                end: 15, top: 15),
                            badgeContent: const Icon(
                              Icons.notifications,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            showBadge: true,
                            badgeAnimation: const badges.BadgeAnimation.rotation(
                              loopAnimation: true,
                              animationDuration: Duration(seconds: 3),
                            ),
                            child: Card(
                              elevation: 2,
                              borderOnForeground: false,
                              surfaceTintColor: const Color.fromARGB(
                                  255, 255, 255, 255),
                              color: const Color.fromARGB(255, 245, 245, 245),
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.asset(
                                "assets/icon-menu/${e.menuId}.png",
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset("assets/images/noimage.jpg"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : Card(
                            elevation: 5,
                            borderOnForeground: false,
                            surfaceTintColor: Colors.white,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(
                                    255, 255, 255, 255),
                              ),
                              child: Image.asset(
                                "assets/icon-menu/${e.menuId}.png",
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset("assets/images/noimage.jpg"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                  );
                },
              ),
            )
    ],
  ),
),

          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            Text(
              "© 2022 IBC Sritrang Corporation. All rights reserved. version $version $ENV",
              style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ],
    );
  }
}
