import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color strokeColor;
  final Color color;
  final double strokeWidth;
  final double fontSize;
  final FontWeight fontWeight;

  const StrokeText({
    Key? key,
    required this.text,
    required this.textStyle,
    this.fontSize = 20,
    this.color = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.strokeColor = Colors.black,
    this.strokeWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()..color = color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..strokeWidth = strokeWidth
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
        ),
      ],
    );
  }
}
