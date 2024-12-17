import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testflutter/screen/landing.dart';
import '../provider-model/profile_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileModel>(context, listen: false).loadFromSharedPreferences();
  }

Future<void> _pickAndSaveImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      Provider.of<ProfileModel>(context, listen: false).setProfileImage(imageBytes);
    }
  }

  void _showEditPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Profile Picture"),
        content: const Text("Choose a new profile picture."),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _pickAndSaveImage();
            },
            child: const Text("Gallery"),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Id');
    await prefs.remove('accesstoken');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Landing()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileModel>(context);
    final profile = profileProvider.profile;

    if (profile.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('โปรไฟล์'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ไม่มีข้อมูลผู้ใช้'),
              ElevatedButton(
                onPressed: () => logout(context),
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => logout(context),
              child: const Text("Logout"),
            ),
            const SizedBox(height: 20),
            Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: profileProvider.profileImage == null
                        ? Image.asset(
                            "assets/images/profile.jpg",
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            profileProvider.profileImage!,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 25,
                    child: GestureDetector(
                      onTap: () => _showEditPopup(context),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              profile[0].employeeName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              profile[0].positionName,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                          Icons.badge,
                          'ID',
                          profile[0].employeeCode.isNotEmpty
                              ? profile[0].employeeCode
                              : 'ไม่มีข้อมูล'),
                      _buildInfoRow(
                          Icons.person,
                          'Nickname',
                          profile[0].employeeNickname.isNotEmpty
                              ? profile[0].employeeNickname
                              : 'ไม่มีข้อมูล'),
                      _buildInfoRow(
                          Icons.apartment,
                          'Department',
                          profile[0].departmentName.isNotEmpty
                              ? profile[0].departmentName
                              : 'ไม่มีข้อมูล'),
                      _buildInfoRow(
                          Icons.business,
                          'Company',
                          profile[0].companyName.isNotEmpty
                              ? profile[0].companyName
                              : 'ไม่มีข้อมูล'),
                      _buildInfoRow(
                          Icons.phone,
                          'Tel.',
                          profile[0].employeeTelephone1.isNotEmpty
                              ? profile[0].employeeTelephone1
                              : 'ไม่มีข้อมูล'),
                      _buildInfoRow(
                          Icons.email,
                          'E-mail',
                          profile[0].employeeEmail1.isNotEmpty
                              ? profile[0].employeeEmail1
                              : 'ไม่มีข้อมูล'),
                      _buildInfoRow(
                          Icons.check_circle,
                          'Status',
                          profile[0].employeeWorkStatus.isNotEmpty
                              ? profile[0].employeeWorkStatus
                              : 'ไม่มีข้อมูล'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 5),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
