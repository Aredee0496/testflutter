import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Map<String, dynamic> jsonResponse = {};

  void getData() async {
    try {
      final body = {
        "Id": "",
      };
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      const URL_API_APP = 'devapistlconnect.sritranggroup.com';
      const VERSION_API_APP = 'v2';

      final url =
          Uri.https(URL_API_APP, "$VERSION_API_APP/sylogin/loginoauthload/");
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        setState(() {
          jsonResponse = jsonData['data'];
        });
      } else {
        setState(() {
          jsonResponse = {"error": "เกิดข้อผิดพลาด: ${response.statusCode}"};
        });
      }
    } catch (e) {
      print('Request failed with status: ${e.toString()}.');
      setState(() {
        setState(() {
          jsonResponse = {"error": "เกิดข้อผิดพลาด: ${e.toString()}"};
        });
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เรียก api"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(8),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ข้อมูล API : ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text("Id: ${jsonResponse['Id'] ?? 'ไม่มีข้อมูล'}"),
                  const SizedBox(height: 3,),
                  Text(
                      "URLOAuth: ${jsonResponse['URLOAuth'] ?? 'ไม่มีข้อมูล'}"),
                  const SizedBox(height: 3,),
                  Text(
                      "URLAPIFamily: ${jsonResponse['URLAPIFamily'] ?? 'ไม่มีข้อมูล'}"),
                  const SizedBox(height: 3,),
                  Text(
                      "PageReDirect: ${jsonResponse['PageReDirect'] ?? 'ไม่มีข้อมูล'}"),
                ],
              )),
        ),
      ),
    );
  }
}
