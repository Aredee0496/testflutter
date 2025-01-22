import 'package:flutter/material.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/family/menu-model.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:badges/badges.dart' as badges;

class MenuHome extends StatefulWidget {
  const MenuHome({super.key});

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  bool loading = false;
  List<Permission> menuAll = [];
  List<Permission> menu = [];
  StorageApp storageApp = StorageApp();

  @override
  void initState() {
    getMenu();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMenu();
    });
  }

  getMenu() async {
    setState(() {
      loading = true;
    });
    DataMenu dataMenu = await storageApp.getMenu();
    setState(() {
      menu = [];
      if (dataMenu.permission.isNotEmpty) {
        final temp = dataMenu.permission;
        for (var i = 0; i < temp.length; i++) {
          final index =
              MENUIDOFDRIVERID.indexWhere((item) => item == temp[i].menuId);
          if (index != -1) {
            menu.add(temp[i]);
          }
          final indexStaff =
              MENUIDOFSTAFF.indexWhere((item) => item == temp[i].menuId);
          if (indexStaff != -1) {
            menu.add(temp[i]);
          }
        }
      }
      print("${menu.length}");
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: Text("loading ...."),
      );
    } else {
      return menu.isEmpty
          ? const Center(
              child: Text("Can't find Menu"),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: menu.map((e) {
                    return CuztomMenu(
                      memuId: e.menuId,
                      memuName: e.menuName,
                      memuName_Alt: e.menuNameAlt,
                      pathUrl: e.pathUrl,
                    );
                  }).toList(),
                ),
              ),
            );
    }
  }
}

class IconMenu {
  IconMenu({
    required this.id,
    required this.icon,
  });
  int id;
  IconData icon;
}

class CuztomMenu extends StatelessWidget {
  const CuztomMenu(
      {super.key,
      required this.memuId,
      required this.memuName,
      required this.memuName_Alt,
      required this.pathUrl,
      this.noti});

  final int memuId;
  final String memuName;
  final String memuName_Alt;
  final String pathUrl;
  final bool? noti;

  @override
  Widget build(BuildContext context) {
    print("pathUrl: $pathUrl");
    return InkWell(
      onTap: () {
        try {
          Navigator.pushNamed(context, pathUrl,
              arguments: {"titlePage": memuName});
        } catch (e) {
          print(e);
        }
      },
      child: badges.Badge(
        badgeContent: Icon(Icons.notifications),
        showBadge: true,
        child: Card(
          elevation: 2,
          borderOnForeground: false,
          surfaceTintColor: Colors.white,
          color: Colors.grey[100],
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            "assets/icon-menu/$memuId.png",
            errorBuilder: (context, error, stackTrace) =>
                Image.asset("assets/images/noimage.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
