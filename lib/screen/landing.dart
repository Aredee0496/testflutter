import 'dart:convert';
import 'dart:developer';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:testflutter/provider-model/family/profile-model.dart';
import 'package:testflutter/provider-model/profile_model.dart';
import 'package:testflutter/screen/login.dart';
import 'package:testflutter/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Map<String, dynamic> jsonResponse = {};
  bool isLoading = true;
  String? id;
  String? token;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedId = prefs.getString('Id');
      String? storedaccesstoken = prefs.getString('accesstoken');
      String? storedrefreshtoken = prefs.getString('refreshtoken');

      if (storedaccesstoken != null &&
          storedaccesstoken != "" &&
          storedrefreshtoken != null &&
          storedrefreshtoken != "") {
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $storedaccesstoken',
        };

        final url = Uri.https(
            'devapistlconnect.sritranggroup.com', '/v1/msplant/geton');
        final response = await http.get(url, headers: headers);
        if (response.statusCode == 200) {
          navigateToHome();
        } else if (response.statusCode == 401) {
          log("Access Token expired. Trying to refresh...");
          await refreshAccessToken(storedrefreshtoken);
        }
      } else {
        if (storedId != null && storedId != "") {
          setState(() {
            id = storedId;
          });
        } else {
          setState(() {
            id = "";
          });
        }

        final body = {
          "Id": id,
        };

        final headers = {
          'Content-Type': 'application/json',
        };
        const urlApiApp = 'devapistlconnect.sritranggroup.com';
        const versionApiApp = 'v2';

        final url =
            Uri.https(urlApiApp, '$versionApiApp/sylogin/loginoauthload/');
        final response =
            await http.post(url, headers: headers, body: jsonEncode(body));
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          String newId = jsonData['data']['Id'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('Id', newId);

          setState(() {
            id = newId;
            isLoading = false;
          });

          if (newId == "") {
            String accesstoken =
                jsonData['data']['dataSTAOAuth']['accesstoken'];
            String refreshtoken =
                jsonData['data']['dataSTAOAuth']['refreshtoken'];
            String user = jsonEncode(jsonData['data']['dataSTAOAuth']['user']);
            String MSEmployee =
                jsonEncode(jsonData['data']['dataSTAOAuth']['MSEmployee']);
            String role = jsonEncode(jsonData['data']['dataSTAOAuth']['role']);

            await prefs.setString('accesstoken', accesstoken);
            await prefs.setString('refreshtoken', refreshtoken);
            await prefs.setString('user', user);
            await prefs.setString('MSEmployee', MSEmployee);
            await prefs.setString('role', role);

            List<dynamic> employeeData = jsonDecode(MSEmployee);
            List<MsEmployee> employees =
                employeeData.map((e) => MsEmployee.fromJson(e)).toList();

            Provider.of<ProfileModel>(context, listen: false)
                .setProfile(employees);
            navigateToHome();
          } else {
            navigateToLogin();
          }
        }
      }
    } catch (e) {
      setState(() {
        jsonResponse = {"error": "เกิดข้อผิดพลาด: ${e.toString()}"};
      });
    }
  }

  Future<void> refreshAccessToken(String refreshToken) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $refreshToken',
    };

    final url = Uri.https(
        'devapistlconnect.sritranggroup.com', '/v1/token/genaccesstoken');
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        String newAccessToken = jsonData['data']['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accesstoken', newAccessToken);

        navigateToHome();
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('accesstoken');
        await prefs.remove('refreshtoken');
        getData();
      }
    } catch (e) {
      log("Error during token refresh: $e");
    }
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade600,
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.fromLTRB(5, 130, 5, 130),
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", fit: BoxFit.cover),
                  const Text("MOBILE MANAGEMENT",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("SRI TRANG GROUP",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    color: Colors.purple,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurple),
                          )
                        : const CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Verify Identity...",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
