import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/provider-model/auth_model.dart';
import 'package:testflutter/provider-model/profile_model.dart';
import 'package:testflutter/screen/landing.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthModel()),
        ChangeNotifierProvider(create: (_) => ProfileModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My title",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Landing(),
    );
  }
}

