// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA3HwnK8Y-O4XIfp2FgzcNBpuc-CVqizdI',
    appId: '1:1094179225450:web:6be9f5ff78ee077fc76f13',
    messagingSenderId: '1094179225450',
    projectId: 'study-app-77b58',
    authDomain: 'study-app-77b58.firebaseapp.com',
    storageBucket: 'study-app-77b58.appspot.com',
    measurementId: 'G-ST16M4XCZX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDm3NJx1lY6-S77o_fK2w8gQeXyoI6P2Jg',
    appId: '1:1094179225450:android:d93dca3e12b02557c76f13',
    messagingSenderId: '1094179225450',
    projectId: 'study-app-77b58',
    storageBucket: 'study-app-77b58.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6589e35WvMkzlAQew5pT-CblPWeNHxMU',
    appId: '1:1094179225450:ios:06fdc310db6326e0c76f13',
    messagingSenderId: '1094179225450',
    projectId: 'study-app-77b58',
    storageBucket: 'study-app-77b58.appspot.com',
    iosClientId: '1094179225450-l30jn40erchd7jumj0i67bg9nb7f5obt.apps.googleusercontent.com',
    iosBundleId: 'com.example.studyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6589e35WvMkzlAQew5pT-CblPWeNHxMU',
    appId: '1:1094179225450:ios:06fdc310db6326e0c76f13',
    messagingSenderId: '1094179225450',
    projectId: 'study-app-77b58',
    storageBucket: 'study-app-77b58.appspot.com',
    iosClientId: '1094179225450-l30jn40erchd7jumj0i67bg9nb7f5obt.apps.googleusercontent.com',
    iosBundleId: 'com.example.studyApp',
  );
}