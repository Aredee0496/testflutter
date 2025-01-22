import 'package:flutter/material.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

Widget titleWithWidget(String title, String requiredfield, Widget widget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 18)),
          Text(requiredfield,
              style: const TextStyle(color: Colors.red, fontSize: 18)),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: widget,
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}

Widget titleWithText(String title, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(text,
            style: TextStyle(
                color: MyColors().primary(),
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}

Widget titleWithTextHeader(BuildContext context, String title, String text) {
  return RichText(
    text: TextSpan(
      text: '',
      style: TextStyle(
          fontSize: 18,
          fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          color: Colors.black87,
          fontWeight: FontWeight.bold),
      children: <TextSpan>[
        TextSpan(
          text: '$title : ',
        ),
        TextSpan(
            text: text,
            style: TextStyle(color: MyColors().primary(), fontSize: 22))
      ],
    ),
  );
}

InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
  );
}

// InputDecoration inputDecorationIcon(IconData icon, String hintText) {
//   return InputDecoration(
//       disabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: MyColors().primary())),
//       enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: MyColors().primary())),
//       focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: MyColors().primary())),
//       isDense: true,
//       hintText: hintText,
//       suffixIcon: Icon(icon),
//       border: OutlineInputBorder(
//           borderSide: BorderSide(color: MyColors().primary())));
// }

InputDecoration inputDecorationIcon(Widget icon, String hintText) {
  return InputDecoration(
    hintText: hintText,
    suffixIcon: icon,
    isDense: true,
  );
}

InputDecoration inputDecorationAutocomplete() {
  return InputDecoration(
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      isDense: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      hintText: "",
      suffixIcon: Center(
          child: SizedBox(
        height: 20,
        width: 20,
        child: Icon(
          Icons.expand_more_sharp,
          color: MyColors().primary(),
        ),
      )),
      suffixIconConstraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())));
}

InputDecorationTheme inputDecorationDropdownMenu() {
  return InputDecorationTheme(
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      isDense: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())));
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      isDense: true,
      labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().primary())));
}
