import 'package:flutter/material.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

Widget myAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title, textAlign: TextAlign.center),
  );
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title,
    this.height = kToolbarHeight,
    this.listWidget,
  });
  final String? title;
  final double? height;
  final List<Widget>? listWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: MyColors().primary(),
      title: Text(
        title ?? "",
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
      actions: listWidget,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height!);
}
