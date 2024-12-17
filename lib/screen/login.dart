import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:testflutter/screen/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/encrypt.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map<String, dynamic> jsonResponse = {};
  bool isLoading = true;
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isusernameFilled = false;
  bool _ispasswordFilled = false;
  bool _obscurePassword = true;
  String appname = "";
  String token = "";
  String userid = "";
  String password = "";

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString('Id');

    try {
      final body = {
        "Id": "$storedId",
      };
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      const urlApiApp = 'devapistlconnect.sritranggroup.com';
      const versionApiApp = 'v2';

      final url = Uri.https(urlApiApp, '$versionApiApp/sylogin/validateid');
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        setState(() async {
          jsonResponse = jsonData['data'];
          appname = jsonResponse['appname'];
          token = jsonResponse['accessToken'];
        });
      } else {
        setState(() {
          jsonResponse = {"error": "เกิดข้อผิดพลาด: ${response.statusCode}"};
        });
      }
    } catch (e) {
      setState(() {
        setState(() {
          jsonResponse = {"error": "เกิดข้อผิดพลาด: ${e.toString()}"};
        });
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getData();

    _usernamecontroller.addListener(() {
      setState(() {
        _isusernameFilled = _usernamecontroller.text.isNotEmpty;
      });
    });

    _passwordcontroller.addListener(() {
      setState(() {
        _ispasswordFilled = _passwordcontroller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  void login() async {
    try {
      userid = _usernamecontroller.text;
      password = _passwordcontroller.text;

      userid = await EncryptData().ecrypt(userid);
      password = await EncryptData().ecrypt(password);

      final headers = {
        'Content-Type': 'application/json',
        'accesstoken': token,
      };

      final body = {"appname": appname, "userid": userid, "password": password};

      const urlApiApp = 'devapistlconnect.sritranggroup.com';
      const versionApiApp = 'v2';

      final url = Uri.https(urlApiApp, '$versionApiApp/sylogin/login');
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var jsonData = jsonDecode(response.body);
      if (!mounted) return;
      if (jsonData['code'] == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Landing()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(jsonData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      jsonResponse = {"error": "เกิดข้อผิดพลาด: ${e.toString()}"};
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoginEnabled = _isusernameFilled && _ispasswordFilled;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            )),
        backgroundColor: const Color.fromARGB(255, 146, 98, 209),
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
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Card(
            elevation: 15,
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.fromLTRB(5, 60, 5, 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: 90,
                  height: 45,
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          appname,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 141, 67, 190),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 320,
                    height: 40,
                    child: TextField(
                      controller: _usernamecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User ID',
                        prefixIcon: Icon(Icons.person),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 320,
                  height: 40,
                  child: TextField(
                    controller: _passwordcontroller,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Change password",
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 133, 133, 133),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 105,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password",
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 133, 133, 133),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 320,
                  height: 40,
                  child: TextButton(
                    onPressed: isLoginEnabled
                        ? () {
                            login();
                          }
                        : null,
                    style: TextButton.styleFrom(
                      backgroundColor: isLoginEnabled
                          ? const Color.fromARGB(255, 0, 162, 255)
                          : const Color.fromARGB(255, 124, 124, 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        "1.2.0@dev",
                        style: TextStyle(
                          color: Color.fromARGB(255, 133, 133, 133),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
