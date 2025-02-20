// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBp7T2izrqy3gnX3g_u_17HTXd1jE7hPLk',
    appId: '1:537961554075:android:b0a48fc0b5c171d20f263e',
    messagingSenderId: '537961554075',
    projectId: 'stl-connect-c78ba',
    storageBucket: 'stl-connect-c78ba.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBldSnjdZyWvQghq4e24lYgjyoqWbh8_6Q',
    appId: '1:537961554075:ios:44fdb116393864050f263e',
    messagingSenderId: '537961554075',
    projectId: 'stl-connect-c78ba',
    storageBucket: 'stl-connect-c78ba.firebasestorage.app',
    iosBundleId: 'com.sritranggroup.stlconnect',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA0KIwEalsU-h9VypEK76zFqDKiss1GHVM',
    appId: '1:537961554075:web:5806a32c19b63bd80f263e',
    messagingSenderId: '537961554075',
    projectId: 'stl-connect-c78ba',
    authDomain: 'stl-connect-c78ba.firebaseapp.com',
    storageBucket: 'stl-connect-c78ba.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBldSnjdZyWvQghq4e24lYgjyoqWbh8_6Q',
    appId: '1:537961554075:ios:44fdb116393864050f263e',
    messagingSenderId: '537961554075',
    projectId: 'stl-connect-c78ba',
    storageBucket: 'stl-connect-c78ba.firebasestorage.app',
    iosBundleId: 'com.sritranggroup.stlconnect',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA0KIwEalsU-h9VypEK76zFqDKiss1GHVM',
    appId: '1:537961554075:web:4a1405dfe97e983d0f263e',
    messagingSenderId: '537961554075',
    projectId: 'stl-connect-c78ba',
    authDomain: 'stl-connect-c78ba.firebaseapp.com',
    storageBucket: 'stl-connect-c78ba.firebasestorage.app',
  );

}