import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlightserviceapp/provider-model/setting_model.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ตั้งค่า",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: MyColors().primary(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView(
          children: [
            Consumer<SettingsModel>(
              builder: (context, settingsModel, child) {
                return Column(
                  children: [
                    SwitchListTile(
                      title: const Text(
                        'ระบบการยืนยันตัวตน',
                        style: TextStyle(fontSize: 20),
                      ),
                      value: settingsModel.isBiometricEnabled,
                      onChanged: (bool value) {
                        settingsModel.toggleBiometric(value);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
