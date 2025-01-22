import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/widgets/show-plant.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  String fullname = "";
  String email = "";
  String role = "";
  StorageApp storageApp = StorageApp();
  @override
  void initState() {
    getName();
    super.initState();
  }

  getName() async {
    try {
      final user = await storageApp.getUser();
      final tempRole = await storageApp.getRole();
      if (user != null) {
        setState(() {
          fullname = user.employeeNameAlt ?? "";
          email = user.employeeEmail1 ?? "";
        });
      }
      if (tempRole != null) {
        setState(() {
          role = tempRole.roleName ?? "-";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/images/STL Connect Logo.png",
                      width: 70,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullname,
                        style: TextStyle(
                            color: MyColors().primary(),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      // Text(
                      //   email,
                      //   style: TextStyle(
                      //       color: Colors.grey[300],
                      //       fontWeight: FontWeight.normal,
                      //       fontSize: 13),
                      // ),
                      Text("Role: $role",
                          style: TextStyle(
                              color: MyColors().primary(),
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      const SwitchPlantWidget()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
