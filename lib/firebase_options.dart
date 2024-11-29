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
    apiKey: 'AIzaSyDNUKeZrKpppmwaf4VRZmrNDMY0xf-MOMo',
    appId: '1:780362264949:web:0c4f9ed4408cfe88c4e33c',
    messagingSenderId: '780362264949',
    projectId: 'memo-edf72',
    authDomain: 'memo-edf72.firebaseapp.com',
    storageBucket: 'memo-edf72.firebasestorage.app',
    measurementId: 'G-WJFSS96D1P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOAgjdTWqnIQ_BAtLy0b_ItFoQTC8BYNk',
    appId: '1:780362264949:android:3f79821bf5700db4c4e33c',
    messagingSenderId: '780362264949',
    projectId: 'memo-edf72',
    storageBucket: 'memo-edf72.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFcQv8kfdvxA44PkleJuSM0-iXsbzDWPM',
    appId: '1:780362264949:ios:73a8c6371d970327c4e33c',
    messagingSenderId: '780362264949',
    projectId: 'memo-edf72',
    storageBucket: 'memo-edf72.firebasestorage.app',
    iosBundleId: 'com.example.qwer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFcQv8kfdvxA44PkleJuSM0-iXsbzDWPM',
    appId: '1:780362264949:ios:73a8c6371d970327c4e33c',
    messagingSenderId: '780362264949',
    projectId: 'memo-edf72',
    storageBucket: 'memo-edf72.firebasestorage.app',
    iosBundleId: 'com.example.qwer',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDNUKeZrKpppmwaf4VRZmrNDMY0xf-MOMo',
    appId: '1:780362264949:web:5433ea53295a85e2c4e33c',
    messagingSenderId: '780362264949',
    projectId: 'memo-edf72',
    authDomain: 'memo-edf72.firebaseapp.com',
    storageBucket: 'memo-edf72.firebasestorage.app',
    measurementId: 'G-XMMW75G13F',
  );
}
