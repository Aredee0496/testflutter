import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Uint8List? profileImage;

  final ImagePicker _picker = ImagePicker();
  final String name = 'รุชดีร์ บิลล่าเต๊ะ';
  final String position = 'Developer';
  final String id = '661010496';
  final String nickname = 'ดี้';
  final String department = 'IT';
  final String company = 'บริษัท ศรีตรัง ไอบีซี จำกัด';
  final dynamic telephone = 0941305135;
  final String email = 'rmail@mail.com';
  final String status = 'ปกติ';

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      await saveProfilePicture(imageBytes);
      setState(() {
        profileImage = imageBytes;
      });
    }
  }

  Future<void> saveProfilePicture(Uint8List imageBytes) async {
    final prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    await prefs.setString('profile_picture', base64Image);
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profile_picture');
    if (base64Image != null) {
      setState(() {
        profileImage = base64Decode(base64Image);
      });
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
              await _pickImage();
            },
            child: const Text("Gallery"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    child: profileImage == null
                        ? Image.asset(
                            "assets/images/profile.jpg",
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            profileImage!,
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
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              position,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.badge, 'ID', id),
                    _buildInfoRow(Icons.person, 'Nickname', nickname),
                    _buildInfoRow(Icons.apartment, 'Department', department),
                    _buildInfoRow(Icons.business, 'Company', company),
                    _buildInfoRow(Icons.phone, 'Tel.', telephone),
                    _buildInfoRow(Icons.email, 'E-mail', email),
                    _buildInfoRow(Icons.check_circle, 'Status', status),
                  ],
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
