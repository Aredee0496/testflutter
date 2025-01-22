import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlightserviceapp/app.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:starlightserviceapp/firebase_options.dart';
import 'package:starlightserviceapp/models/app/menu-noti-model.dart';
import 'package:starlightserviceapp/models/family/profile-model.dart';
import 'package:starlightserviceapp/provider-model/password_criteria_provider.dart';
import 'package:starlightserviceapp/provider-model/profile_model.dart';
import 'package:starlightserviceapp/provider-model/setting_model.dart';
import 'package:starlightserviceapp/services/app/notifications-service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}

void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Plugin must be initialized before using
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotifications.init();
  // initialize local notifications
  // dont use local notifications for web platform
  // if (!kIsWeb) {
  //   await PushNotifications.localNotiInit();
  // }

  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/home", arguments: message);
    }
  });

// to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);

    if (message.notification != null) {
      if (kIsWeb) {
        showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!);
      } else {
        PushNotifications.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/home", arguments: message);
    });
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProfileModel()),
    ChangeNotifierProvider<ProfileModel2>(create: (_) => ProfileModel2()),
    ChangeNotifierProvider(create: (context) => SettingsModel()),
    ChangeNotifierProvider(create: (_) => MenuNotiModel()),
    ChangeNotifierProvider(create: (_) => PasswordCriteriaProvider()),
  ], child: const MyApp()));
}
