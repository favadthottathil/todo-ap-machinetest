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
    apiKey: 'AIzaSyAmT7uKAvTbsBSnUbqTdrkHPUWBjl4R5HU',
    appId: '1:666236032377:web:9d95bac1e07c33f5348ba8',
    messagingSenderId: '666236032377',
    projectId: 'todo-app-d-fine',
    authDomain: 'todo-app-d-fine.firebaseapp.com',
    storageBucket: 'todo-app-d-fine.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz0vWbx0RJc7fPElY1KPo0cH4Y7SfUgCA',
    appId: '1:666236032377:android:baaef58614f9aa31348ba8',
    messagingSenderId: '666236032377',
    projectId: 'todo-app-d-fine',
    storageBucket: 'todo-app-d-fine.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9eddREthO5N1fwXHhQ_VNBWyaAvLKLmQ',
    appId: '1:666236032377:ios:3b231238d3f02127348ba8',
    messagingSenderId: '666236032377',
    projectId: 'todo-app-d-fine',
    storageBucket: 'todo-app-d-fine.appspot.com',
    iosBundleId: 'com.example.dFineMachineTest',
  );
}
