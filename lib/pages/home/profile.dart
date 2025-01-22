import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/widgets/background.dart';
import '../../provider-model/profile_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showEditPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Change Profile Picture"),
        content: const Text("Choose a new profile picture."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _pickAndSaveImage(context);
            },
            child: const Text("Gallery"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndSaveImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();

      Provider.of<ProfileModel2>(context, listen: false)
          .setProfileImage(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileModel2>(
      builder: (context, profileProvider, child) {
        if (profileProvider.profile.isEmpty) {
          profileProvider.loadFromSharedPreferences();
        }

        final profile = profileProvider.profile;
        final profileImage = profileProvider.profileImage;

        return Stack(
          children: [
            const MyBackground(),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text(
                  'โปรไฟล์',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
              ),
              body: profile.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('ไม่มีข้อมูลผู้ใช้')],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: MyColors().primary(),
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: profileImage != null
                                      ? Image.memory(
                                          profileImage,
                                          fit: BoxFit.cover,
                                          gaplessPlayback: true,
                                        )
                                      : Image.asset("assets/images/person.png"),
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
                                        color: Color(0xFF00E676),
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
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white ,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profile[0].positionName,
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                          Card(
                            elevation: 5,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          profile[0]
                                                  .employeeTelephone1
                                                  .isNotEmpty
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
                                          profile[0]
                                                  .employeeWorkStatus
                                                  .isNotEmpty
                                              ? profile[0].employeeWorkStatus
                                              : 'ไม่มีข้อมูล'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        );
      },
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
