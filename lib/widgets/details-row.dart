import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowDataDetails extends StatelessWidget {
  ShowDataDetails(
      {super.key, required this.title, required this.value, this.colorValue});

  String title;
  String value;
  Color? colorValue;

  double fontSize = 18;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '$title : ',
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: fontSize),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorValue ?? Colors.black,
                fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}
