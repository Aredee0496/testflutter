import "package:flutter/material.dart";
import 'package:testflutter/screen/landing.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isusernameFilled = false;
  bool _ispasswordFilled = false;
  bool _obscurePassword = true;

  @override
  void initState() {
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
    return SingleChildScrollView(
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
              const Center(
                child: Text('STL Connect',
                    style: TextStyle(
                        color: Color.fromARGB(255, 141, 67, 190),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Landing()),
                          );
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
        ));
  }
}
