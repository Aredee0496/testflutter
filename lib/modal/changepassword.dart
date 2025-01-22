import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starlightserviceapp/encrypt.dart';
import 'package:starlightserviceapp/provider-model/password_criteria_provider.dart';

class ChangePasswordModal {
  static void show(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController userIdController = TextEditingController();
    final TextEditingController oldPasswordController = TextEditingController();

    bool obscureOldPassword = true;
    bool obscureNewPassword = true;
    bool obscureConfirmPassword = true;

    Future<void> changepassword() async {
      final currentTime = DateFormat("yyyyMMDDhhmmss").format(DateTime.now());
      final tempdata = {
        'u': userIdController.text,
        'o': oldPasswordController.text,
        'n': newPasswordController.text,
        't': currentTime,
      };

      final String strdata = jsonEncode(tempdata);
      final encrypteddata = await EncryptData().encrypt(strdata);

      try {
        final body = {
          "value": encrypteddata,
        };

        final headers = {
          'Content-Type': 'application/json; charset=UTF-8',
        };
        const urlApiApp = 'devapistlconnect.sritranggroup.com';

        final url = Uri.https(urlApiApp, '/v1/syuserlogin/changepass/');
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
                    ),
                  ),
                  content: const Text(
                      'เปลี่ยนรหัสผ่านสำเร็จ'),
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
                    style: const TextStyle(
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

    void clearFields() {
      userIdController.clear();
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: Provider.of<PasswordCriteriaProvider>(context, listen: false),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final provider =
                  Provider.of<PasswordCriteriaProvider>(context, listen: true);

              return AlertDialog(
                title: const Text(
                  'Change Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: userIdController,
                        decoration: const InputDecoration(
                          labelText: 'User ID',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: oldPasswordController,
                        obscureText: obscureOldPassword,
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(obscureOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                obscureOldPassword = !obscureOldPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: newPasswordController,
                        obscureText: obscureNewPassword,
                        onChanged: (value) {
                          provider.validatePassword(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureNewPassword = !obscureNewPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: provider.isPasswordValid
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        onChanged: (value) {
                          provider.validateConfirmPassword(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureConfirmPassword =
                                    !obscureConfirmPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: provider.passwordsMatch
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          errorText: provider.passwordsMatch
                              ? null
                              : 'Passwords do not match',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCriteriaRow(
                              provider.hasMinLength, 'At least 8 characters'),
                          _buildCriteriaRow(
                              provider.hasUppercase, 'Uppercase (A-Z)'),
                          _buildCriteriaRow(
                              provider.hasLowercase, 'Lowercase (a-z)'),
                          _buildCriteriaRow(provider.hasNumber, 'Number (0-9)'),
                          _buildCriteriaRow(provider.hasSpecialChar,
                              'Special character (!@#\$...)'),
                          if (provider.hasMinLength &&
                              provider.hasUppercase &&
                              provider.hasLowercase &&
                              provider.hasNumber &&
                              provider.hasSpecialChar)
                            _buildCriteriaRow(provider.passwordsMatch,
                                'Confirm password matches new password'),
                        ],
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      clearFields();
                      provider.resetCriteria();
                    },
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: provider.isPasswordValid &&
                            newPasswordController.text ==
                                confirmPasswordController.text
                        ? () async {
                            changepassword();
                            clearFields();
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: const Text('CHANGE'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  static Widget _buildCriteriaRow(bool isValid, String text) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
