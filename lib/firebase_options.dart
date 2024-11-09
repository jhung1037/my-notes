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
    apiKey: 'AIzaSyDAH6bN0igvHyVpleKPiAY62-uPiiqBbaI',
    appId: '1:271118461090:web:102215e83c82213b710ffb',
    messagingSenderId: '271118461090',
    projectId: 'mynotes-jhung',
    authDomain: 'mynotes-jhung.firebaseapp.com',
    storageBucket: 'mynotes-jhung.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoUUSFmFk2VwlNtGP3jp19kzhI9XtEgHw',
    appId: '1:271118461090:android:85d249def427bb81710ffb',
    messagingSenderId: '271118461090',
    projectId: 'mynotes-jhung',
    storageBucket: 'mynotes-jhung.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDja6ilvmCKTTxy7NaBiPp3NJOJi_2KKXQ',
    appId: '1:271118461090:ios:9d5bb0c8ca0cca77710ffb',
    messagingSenderId: '271118461090',
    projectId: 'mynotes-jhung',
    storageBucket: 'mynotes-jhung.appspot.com',
    iosBundleId: 'com.example.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDja6ilvmCKTTxy7NaBiPp3NJOJi_2KKXQ',
    appId: '1:271118461090:ios:9d5bb0c8ca0cca77710ffb',
    messagingSenderId: '271118461090',
    projectId: 'mynotes-jhung',
    storageBucket: 'mynotes-jhung.appspot.com',
    iosBundleId: 'com.example.mynotes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDAH6bN0igvHyVpleKPiAY62-uPiiqBbaI',
    appId: '1:271118461090:web:890fd18b48ed5319710ffb',
    messagingSenderId: '271118461090',
    projectId: 'mynotes-jhung',
    authDomain: 'mynotes-jhung.firebaseapp.com',
    storageBucket: 'mynotes-jhung.appspot.com',
  );
}