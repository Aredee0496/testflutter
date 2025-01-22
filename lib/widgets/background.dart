import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  final Widget? child;

  const MyBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
          Color(0xFF6A1B9A), 
          Color(0xFF9C27B0), 
          Color(0xFFAB47BC), 
          Color.fromARGB(255, 246, 211, 255),
        ],
        ),
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover, 
          opacity: 0.3, 
        ),
      ),
      child: child,
    );
  }
}
