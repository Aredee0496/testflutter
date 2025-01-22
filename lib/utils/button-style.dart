import 'package:flutter/material.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

class MyStyle {
  button() {
    return BoxDecoration(
        border: Border.all(
          width: 1,
          color: MyColors().primary(),
        ),
        borderRadius: BorderRadius.circular(60));
  }

  elevatedButton() {
    return ElevatedButton.styleFrom(
        backgroundColor: MyColors().primary(),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
  }

  outlinedButton(Color color) {
    return OutlinedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(
          width: 2,
          color: color,
        ));
  }
}
