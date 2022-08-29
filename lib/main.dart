import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/app.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        projectId: 'tlearn-d688e',
        apiKey: 'AIzaSyC6_LmMiKEh1fG2JgL7w3zsrrYcMFozQBU',
        messagingSenderId: '774647363949',
        appId: '1:774647363949:android:c5048fe59a5d9b95f50264'
    )
  );

  await EasyLocalization.ensureInitialized();

  runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ta')],
        path: 'assets/language',
        fallbackLocale: const Locale('ta'),
        child:  const App() ));
}