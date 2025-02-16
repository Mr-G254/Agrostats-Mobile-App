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
    apiKey: 'AIzaSyBVGciDwmY-XMKr7FJveq34CH1QNStm2as',
    appId: '1:444204536721:web:5d3f2ae1dd54120168c030',
    messagingSenderId: '444204536721',
    projectId: 'agrostats-cbaf9',
    authDomain: 'agrostats-cbaf9.firebaseapp.com',
    storageBucket: 'agrostats-cbaf9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCOlu-8OYFAX_5DJY8Hg0F0P_dDAYhF8w',
    appId: '1:444204536721:android:d31536479b31884668c030',
    messagingSenderId: '444204536721',
    projectId: 'agrostats-cbaf9',
    storageBucket: 'agrostats-cbaf9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7jUxI2XhdybKxxcSUTxBKZtVVmI_-8xo',
    appId: '1:444204536721:ios:16217e0f7e834f8268c030',
    messagingSenderId: '444204536721',
    projectId: 'agrostats-cbaf9',
    storageBucket: 'agrostats-cbaf9.appspot.com',
    iosBundleId: 'com.example.agristats',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7jUxI2XhdybKxxcSUTxBKZtVVmI_-8xo',
    appId: '1:444204536721:ios:16217e0f7e834f8268c030',
    messagingSenderId: '444204536721',
    projectId: 'agrostats-cbaf9',
    storageBucket: 'agrostats-cbaf9.appspot.com',
    iosBundleId: 'com.example.agristats',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBVGciDwmY-XMKr7FJveq34CH1QNStm2as',
    appId: '1:444204536721:web:6a36b0759a208d6e68c030',
    messagingSenderId: '444204536721',
    projectId: 'agrostats-cbaf9',
    authDomain: 'agrostats-cbaf9.firebaseapp.com',
    storageBucket: 'agrostats-cbaf9.appspot.com',
  );
}
