import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/models/family/auth-model.dart';
import 'package:starlightserviceapp/models/family/response.dart';
import 'package:starlightserviceapp/services/app/notifications-service.dart';
import 'package:starlightserviceapp/services/family-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/utils/hexcolor.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class BoxSelection {
  bool selected;
  String title;
  String details;

  BoxSelection(
      {required this.selected, required this.title, required this.details});
}

class _PlantPageState extends State<PlantPage> {
  List<PlantCode> itemsPlant = [];
  FamilyService familyService = FamilyService();
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
    Role role = await storageApp.getRole();
    setState(() {
      itemsPlant = [];
      itemsPlant = role.plantCode ?? [];
    });
  }

  onSelectedPlant(String plantcode) async {
    try {
      DialogHelper.showLoading(context);
      StorageApp storageApp = StorageApp();
      String token = await storageApp.getAccessToken();
      ResponseModel responseModel =
          await familyService.switchPlant(context, plantcode, token);
      if (responseModel.result == "success") {
        await storageApp.setPlant(plantcode);
        final processNoti = await PushNotifications().saveTokenNoti(context);
        if (processNoti == "") {
          DialogHelper.hideLoading(context);
          Navigator.pushNamedAndRemoveUntil(
              context, '/', (Route<dynamic> route) => false);
        } else {
          DialogHelper.hideLoading(context);
          DialogHelper.showErrorMessageDialog(context, processNoti);
        }
      } else {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, responseModel.message);
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      DialogHelper.showErrorMessageDialog(context, "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Select Plant",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: HexColor("#9F74DC"),
        centerTitle: true,
      ),
      body: itemsPlant.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor("#9F74DC"),
                    ),
                    child: ListTile(
                      title: Text(
                        itemsPlant[index].plantCode ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        itemsPlant[index].plantName ?? "",
                        style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.normal),
                      ),
                      trailing: ElevatedButton(
                          onPressed: () {
                            onSelectedPlant(itemsPlant[index].plantCode ?? "");
                          },
                          child: Text("Select")),
                    ),
                  ),
                );
              },
              itemCount: itemsPlant.length),
    );
  }
}
