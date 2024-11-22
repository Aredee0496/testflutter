import 'package:flutter/material.dart';
import 'package:testflutter/screen/home.dart';

void main() {
  runApp(MaterialApp(
    title: "My title",
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Login",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            )),
        backgroundColor: const Color.fromARGB(255, 170, 123, 201),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: const Home(),
    ),
  ));
}
