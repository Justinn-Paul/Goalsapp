import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // if (kIsWeb) {
    //   return web;
    // }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // case TargetPlatform.iOS:
      //   return ios;
      // case TargetPlatform.macOS:
      //   return macos;
      // case TargetPlatform.windows:
      //   return windows;
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

  // // Firebase project settings
  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'your-api-key',
  //   appId: 'your-app-id',
  //   messagingSenderId: 'your-sender-id',
  //   projectId: 'your-project-id',
  //   authDomain: 'your-project-id.firebaseapp.com',
  //   storageBucket: 'your-project-id.appspot.com',
  // );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgVeKlHrXOHkPuBs2gH6AgrJw9XBQpGdI',
    appId: '1:999307704481:android:41bc6ecacb64808c7818e0',
    messagingSenderId: '999307704481',
    projectId: 'faithgoalapp',
    storageBucket: 'faithgoalapp.firebasestorage.app',
  );

  //   static const FirebaseOptions ios = FirebaseOptions(
  //     apiKey: 'your-api-key',
  //     appId: 'your-app-id',
  //     messagingSenderId: 'your-sender-id',
  //     projectId: 'your-project-id',
  //     storageBucket: 'your-project-id.appspot.com',
  //     iosClientId: 'your-ios-client-id',
  //     iosBundleId: 'com.example.goalsapp',
  //   );

  //   static const FirebaseOptions macos = FirebaseOptions(
  //     apiKey: 'your-api-key',
  //     appId: 'your-app-id',
  //     messagingSenderId: 'your-sender-id',
  //     projectId: 'your-project-id',
  //     storageBucket: 'your-project-id.appspot.com',
  //     iosClientId: 'your-ios-client-id',
  //     iosBundleId: 'com.example.goalsapp',
  //   );

  //   static const FirebaseOptions windows = FirebaseOptions(
  //     apiKey: 'your-api-key',
  //     appId: 'your-app-id',
  //     messagingSenderId: 'your-sender-id',
  //     projectId: 'your-project-id',
  //     storageBucket: 'your-project-id.appspot.com',
  //   );
  //
}
