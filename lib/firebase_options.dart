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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAFTTxYSG_MfiN9fmXMuyaQXZJbM0A1cko',
    appId: '1:946285433808:web:be5e521dcafd2dd4c15fd5',
    messagingSenderId: '946285433808',
    projectId: 'todo-application-f54f0',
    authDomain: 'todo-application-f54f0.firebaseapp.com',
    storageBucket: 'todo-application-f54f0.firebasestorage.app',
    measurementId: 'G-L853274ML8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvgNPIlagMc_11cKF1FcCyGUzoTji56qo',
    appId: '1:946285433808:android:c78ac3f260d1353ec15fd5',
    messagingSenderId: '946285433808',
    projectId: 'todo-application-f54f0',
    storageBucket: 'todo-application-f54f0.firebasestorage.app',
  );

}