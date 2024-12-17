import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/screen/profile.dart';

import '../provider-model/profile_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   @override
  void initState() {
    super.initState();
    Provider.of<ProfileModel>(context, listen: false).loadFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "STL Connect",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade500,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            icon: Consumer<ProfileModel>(
              builder: (context, profileModel, child) {
                if (profileModel.profileImage != null) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: MemoryImage(profileModel.profileImage!),
                  );
                } else {
                  return const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 40,
                  );
                }
              },
            ),
            iconSize: 40,
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome to the home page!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
