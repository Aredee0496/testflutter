import 'package:flutter/material.dart';
import 'package:starlightserviceapp/pages/plant.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/widgets/dialog-confirm.dart';

class SwitchPlantWidget extends StatefulWidget {
  const SwitchPlantWidget({super.key});

  @override
  State<SwitchPlantWidget> createState() => _SwitchPlantWidgetState();
}

class _SwitchPlantWidgetState extends State<SwitchPlantWidget> {
  StorageApp storageApp = StorageApp();
  String plantcode = "";
  String fullname = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }

  getData() async {
    StorageApp storageApp = StorageApp();
    String temp = await storageApp.getPlant();
    final user = await storageApp.getUser();
    print("$user");
    setState(() {
      plantcode = temp;
      if (user != "") fullname = user.employeeNameAlt ?? "";
    });
  }

  changePlant() {
    showDialog(
        context: context,
        builder: (context) {
          return dialogConfirm(context, "Change?", "Do you want change plant");
        }).then((value) async {
      if (value == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PlantPage()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            changePlant();
          },
          child: Row(
            children: [
              Text(
                plantcode,
                style: TextStyle(
                    color: MyColors().primary(),
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}
