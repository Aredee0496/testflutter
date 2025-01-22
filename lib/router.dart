import 'package:flutter/material.dart';
import 'package:starlightserviceapp/pages/home/home.dart';
import 'package:starlightserviceapp/pages/home/setting.dart';
import 'package:starlightserviceapp/pages/jobmoving/jobmoving.dart';
import 'package:starlightserviceapp/pages/landing.dart';
import 'package:starlightserviceapp/pages/notilist.dart';
import 'package:starlightserviceapp/pages/home/profile.dart';
import 'package:starlightserviceapp/pages/tank-driver/tank-driver.dart';
import 'package:starlightserviceapp/pages/tank-tank/tank-tank.dart';
import 'package:starlightserviceapp/pages/transportclearing/transportclearing.dart';
import 'package:starlightserviceapp/pages/worklist/worklist.dart';
import 'package:starlightserviceapp/pages/worklist2/worklist2.dart';

myRoutes(BuildContext context) {
  return {
    '/': (context) => const LandingPage(),
    // '/': (context) => WorklistDetailsPage(
    //       id: "aaa",

    //       jobStatus: "ssss",
    //     ),
    '/home': (context) => const MyHomePage(),
    '/towingmovingorders': (context) => const JobMovingPage(),
    '/worklistdriver': (context) => const WorklistPage(),
    '/worklistdriver2': (context) => const WorklistPage2(),
    '/profile': (context) => const ProfilePage(),
    '/setting': (context) => const SettingsPage(),
    '/tankmanagementmbdriver': (context) => const TankDriverPage(),
    '/transportclearingdriver': (context) => const TransportClearingPage(),
    '/tankmanagementmbtank': (context) => const TankTankPage(),
    '/notilist': (context) => const Message()
  };
}
