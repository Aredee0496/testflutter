import 'package:flutter/material.dart';
import 'package:starlightserviceapp/models/family/menu-model.dart';

class MenuNotiModel extends ChangeNotifier {
  List<Permission> _menu = [];

  List<Permission> get menu => _menu;

  set menu(List<Permission> item) {
    _menu = item;
    print("_menu => ${_menu.length}");
    notifyListeners();
  }

  updateShowNotiMenuId(int menuId) {
    _menu.map((e) {
      if (e.menuId == menuId) {
        e.noti = true;
      }
    }).toList();
    notifyListeners();
  }

  updateRemoveNotiMenuId(int menuId) {
    _menu.map((e) {
      if (e.menuId == menuId) {
        e.noti = false;
      }
    }).toList();
    notifyListeners();
  }
}
