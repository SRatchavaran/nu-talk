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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB6sjZXJPLmoY_JWUZa9ivxJAi0vdYoG2g',
    appId: '1:732396582602:web:bb8d9a3c4c175532a72633',
    messagingSenderId: '732396582602',
    projectId: 'nutalk',
    authDomain: 'nutalk.firebaseapp.com',
    storageBucket: 'nutalk.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANesv4PH8zd3Igz8qQ9A-tFfHtY2FEZu8',
    appId: '1:732396582602:android:3b1fa12be2784e4ea72633',
    messagingSenderId: '732396582602',
    projectId: 'nutalk',
    storageBucket: 'nutalk.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy9vwUohNYoJAZPfcReyDo3zWT0vZjpZc',
    appId: '1:732396582602:ios:361157d0b9e88186a72633',
    messagingSenderId: '732396582602',
    projectId: 'nutalk',
    storageBucket: 'nutalk.appspot.com',
    iosBundleId: 'com.example.nutalk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAy9vwUohNYoJAZPfcReyDo3zWT0vZjpZc',
    appId: '1:732396582602:ios:361157d0b9e88186a72633',
    messagingSenderId: '732396582602',
    projectId: 'nutalk',
    storageBucket: 'nutalk.appspot.com',
    iosBundleId: 'com.example.nutalk',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB6sjZXJPLmoY_JWUZa9ivxJAi0vdYoG2g',
    appId: '1:732396582602:web:7d40773e7d553083a72633',
    messagingSenderId: '732396582602',
    projectId: 'nutalk',
    authDomain: 'nutalk.firebaseapp.com',
    storageBucket: 'nutalk.appspot.com',
  );
}
