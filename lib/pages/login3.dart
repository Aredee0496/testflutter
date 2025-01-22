import "package:flutter/material.dart";
import 'package:starlightserviceapp/modal/changepassword.dart';
import 'package:starlightserviceapp/modal/forgotpassword.dart';
import 'package:starlightserviceapp/models/family/getdata-model.dart';
import 'package:starlightserviceapp/models/family/login-model.dart';
import 'package:starlightserviceapp/pages/landing.dart';
import 'package:starlightserviceapp/widgets/background.dart';
import '/services/app/login-service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  Map<String, dynamic> jsonResponse = {};
  LoginService loginService = LoginService();
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
    GetIdModelData getIdModelData = await loginService.getData(context);
    setState(() {
      appname = getIdModelData.appname;
      token = getIdModelData.accessToken;
      isLoading = false;
    });
  }

  void Login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 147, 45, 231)),
                ),
                SizedBox(height: 20),
                Text(
                  "กำลังตรวจสอบ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 189, 63),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      userid = _usernamecontroller.text;
      password = _passwordcontroller.text;

      LoginModel loginModel =
          await loginService.Login(context, userid, password, appname, token);

      Navigator.of(context).pop();

      if (loginModel.code == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(
                color: Color.fromARGB(255, 224, 1, 1),
              ),
              textAlign: TextAlign.center,
            ),
            content: Text(e.toString()),
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
  }

  @override
  void initState() {
    getData();
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    final bool isLoginEnabled = _isusernameFilled && _ispasswordFilled;
    return Stack(
      children: [
        const MyBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "Login",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 28,
              ),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    getData();
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Card(
              elevation: 15,
              margin: const EdgeInsets.fromLTRB(5, 60, 5, 120),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Image.asset(
                      "assets/images-sritrang/favicon.png",
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
                          onPressed: () {
                            ChangePasswordModal.show(context);
                          },
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
                          width: 160,
                        ),
                        TextButton(
                          onPressed: () {
                            ForgotPasswordModal.show(context);
                          },
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
                                Login();
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
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
