import 'package:flutter/material.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

Widget dialogConfirm(BuildContext context, String title, String message) {
  return AlertDialog(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    title: Center(
      child: Text(
        title,
        style: TextStyle(color: MyColors().primary()),
      ),
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            style: MyStyle().outlinedButton(
              Colors.red,
            ),
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ยกเลิก',
                style: TextStyle(fontSize: 20, color: Colors.red)),
          ),
          ElevatedButton(
            style: MyStyle().elevatedButton(),
            onPressed: () => Navigator.pop(context, true),
            child: Text('ยืนยัน',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ],
      ),
    ],
  );
}

Widget dialogConfirmDelete(BuildContext context, String title, String message) {
  return AlertDialog(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    title: Center(
      child: Text(
        title,
        style: TextStyle(color: MyColors().primary()),
      ),
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            style: MyStyle().outlinedButton(
              Colors.grey,
            ),
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ยกเลิก',
                style: TextStyle(fontSize: 20, color: Colors.grey)),
          ),
          ElevatedButton(
            style: MyStyle().outlinedButton(
              Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text('ยืนยัน',
                style: TextStyle(fontSize: 20, color: Colors.red)),
          ),
        ],
      ),
    ],
  );
}
