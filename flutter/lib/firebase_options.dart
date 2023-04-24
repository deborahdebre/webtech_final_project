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
    apiKey: 'AIzaSyD-eiqA10m-Sd-JNcp8LkrpQdi-ZYdzIOc',
    appId: '1:968082326644:web:4091422c4e20e6d7b77d21',
    messagingSenderId: '968082326644',
    projectId: 'webtechproject-1',
    authDomain: 'webtechproject-1.firebaseapp.com',
    storageBucket: 'webtechproject-1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbfQ5nWZGlVkjQKRZSZvpdsLp-bZq6tPk',
    appId: '1:968082326644:android:ca12a67ca447bfd4b77d21',
    messagingSenderId: '968082326644',
    projectId: 'webtechproject-1',
    storageBucket: 'webtechproject-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJi2KhtXzR_WSn0SqsXd_XXMpLkv0gTlw',
    appId: '1:968082326644:ios:5c492ddd7138d8e6b77d21',
    messagingSenderId: '968082326644',
    projectId: 'webtechproject-1',
    storageBucket: 'webtechproject-1.appspot.com',
    iosClientId: '968082326644-itn577qc0c138jlj0p68lum0mmdom8iq.apps.googleusercontent.com',
    iosBundleId: 'com.example.finalProj14',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJi2KhtXzR_WSn0SqsXd_XXMpLkv0gTlw',
    appId: '1:968082326644:ios:5c492ddd7138d8e6b77d21',
    messagingSenderId: '968082326644',
    projectId: 'webtechproject-1',
    storageBucket: 'webtechproject-1.appspot.com',
    iosClientId: '968082326644-itn577qc0c138jlj0p68lum0mmdom8iq.apps.googleusercontent.com',
    iosBundleId: 'com.example.finalProj14',
  );
}
