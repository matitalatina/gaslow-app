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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRYuaZXr1iJ1_pO3TcgG-S4mEHjR4rwAk',
    appId: '1:305821023764:android:538fa7b177238dd1',
    messagingSenderId: '305821023764',
    projectId: 'gaslow-dev',
    databaseURL: 'https://gaslow-dev.firebaseio.com',
    storageBucket: 'gaslow-dev.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC26VXRxbLdcpApdvUtRiO58QRn0UzkADU',
    appId: '1:305821023764:ios:1e6d4d97bb2677739db101',
    messagingSenderId: '305821023764',
    projectId: 'gaslow-dev',
    databaseURL: 'https://gaslow-dev.firebaseio.com',
    storageBucket: 'gaslow-dev.firebasestorage.app',
    iosClientId: '305821023764-ijm1fevg9cj63p7bfgq5vla2n1ao6gq1.apps.googleusercontent.com',
    iosBundleId: 'it.mattianatali.gaslow',
  );
}
