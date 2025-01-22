import 'package:flutter/material.dart';
import 'package:starlightserviceapp/utils/button-style.dart';

Widget dialogMessage(BuildContext context, String title, String message) {
  return AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.warning_rounded,
            color: Colors.red,
          ),
        ),
        Text(title),
      ],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
      ],
    ),
    actionsAlignment: MainAxisAlignment.center,
    actions: <Widget>[
      ElevatedButton(
        style: MyStyle().elevatedButton(),
        child: const Text('Back',
            style: TextStyle(fontSize: 20, color: Colors.red)),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}
