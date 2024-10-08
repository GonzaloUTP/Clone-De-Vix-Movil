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
    apiKey: 'AIzaSyBxwBlNPlfxaClWJkh4YFwYHyKUb3a_B14',
    appId: '1:191587132522:web:33984bc6da4b9a1906d613',
    messagingSenderId: '191587132522',
    projectId: 'tarea-2eb2a',
    authDomain: 'tarea-2eb2a.firebaseapp.com',
    storageBucket: 'tarea-2eb2a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdp_z4bf8MW889l_4Rl68Ruui_HfPVWjw',
    appId: '1:191587132522:android:71e04cfc49fb52c606d613',
    messagingSenderId: '191587132522',
    projectId: 'tarea-2eb2a',
    storageBucket: 'tarea-2eb2a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCetmdEms_zHEkF3plkCqDheg_1UsnrqFs',
    appId: '1:191587132522:ios:1f5eb1c1c099394606d613',
    messagingSenderId: '191587132522',
    projectId: 'tarea-2eb2a',
    storageBucket: 'tarea-2eb2a.appspot.com',
    iosClientId: '191587132522-7css4p1dk3fuhmbt15dco8f9nqlqvopq.apps.googleusercontent.com',
    iosBundleId: 'com.example.clondevix',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCetmdEms_zHEkF3plkCqDheg_1UsnrqFs',
    appId: '1:191587132522:ios:1f5eb1c1c099394606d613',
    messagingSenderId: '191587132522',
    projectId: 'tarea-2eb2a',
    storageBucket: 'tarea-2eb2a.appspot.com',
    iosClientId: '191587132522-7css4p1dk3fuhmbt15dco8f9nqlqvopq.apps.googleusercontent.com',
    iosBundleId: 'com.example.clondevix',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBxwBlNPlfxaClWJkh4YFwYHyKUb3a_B14',
    appId: '1:191587132522:web:00842fa7880cebe206d613',
    messagingSenderId: '191587132522',
    projectId: 'tarea-2eb2a',
    authDomain: 'tarea-2eb2a.firebaseapp.com',
    storageBucket: 'tarea-2eb2a.appspot.com',
  );

}