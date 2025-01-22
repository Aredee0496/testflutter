import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:starlightserviceapp/encrypt.dart';

class ForgotPasswordModal {
  static void show(BuildContext context) {
    final TextEditingController userIdController = TextEditingController();
    bool isButtonEnabled = false;

    Future<void> forgotpassword() async {
      final currentTime = DateTime.now();
      final currentTimeString =
          DateFormat("yyyyMMDDhhmmss").format(currentTime);

      final timePlus10Min = currentTime.add(const Duration(minutes: 10));
      final timePlus10MinString =
          DateFormat("yyyyMMDDhhmmss").format(timePlus10Min);

      final tempdata = {
        'u': userIdController.text,
        't': currentTimeString,
        'e': timePlus10MinString,
      };

      print(tempdata);

      final String strdata = jsonEncode(tempdata);
      print(strdata);
      final encrypteddata = await EncryptData().encrypt(strdata);
      print("encryptdata $encrypteddata");

      try {
        final body = {
          "value": "$encrypteddata",
        };
        print("body $body");

        final headers = {
          'Content-Type': 'application/json; charset=UTF-8',
        };
        const urlApiApp = 'devapistlconnect.sritranggroup.com';

        final url = Uri.https(urlApiApp, '/v1/syuserlogin/forgetpass/');
        final response =
            await http.post(url, headers: headers, body: jsonEncode(body));
        var jsonData = jsonDecode(response.body);
        String result = jsonData['result'];
        String message = jsonData['message'];
        if (response.statusCode == 200) {
          if (jsonData['result'] == 'success') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Result: $result',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 180, 39),
                    ), textAlign: TextAlign.center, 
                  ),
                  content: const Text('ระบบจะส่งคำขอของท่านไปยังหัวหน้า/ผู้จัดการบัญชีสำเร็จ'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Error',
                    style:  TextStyle(
                      color: Color.fromARGB(255, 224, 1, 1),
                    ), textAlign: TextAlign.center, 
                  ),
                  content:
                      Text('Error: ${response.statusCode}, $message'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Error',
                  style: TextStyle(
                    color: Color.fromARGB(255, 224, 1, 1),
                  ),
                ),
                content: Text('Error: ${response.statusCode}, $message'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print('An error occurred: error');
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Text(
                'Forgot password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ระบบจะส่งคำขอของท่านไปยังหัวหน้า/ผู้จัดการบัญชี เพื่อรีเซ็ตรหัสผ่าน',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: userIdController,
                    onChanged: (value) {
                      setState(() {
                        isButtonEnabled = value.trim().isNotEmpty;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'User ID',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          String userId = userIdController.text.trim();
                          if (userId.isNotEmpty) {
                            forgotpassword();
                            Navigator.of(context).pop();
                          }
                        }
                      : null,
                  child: const Text('REQUEST'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
