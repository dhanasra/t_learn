import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        projectId: 'tlearn-d688e',
        apiKey: 'AIzaSyC6_LmMiKEh1fG2JgL7w3zsrrYcMFozQBU',
        messagingSenderId: '774647363949',
        appId: '1:774647363949:android:c5048fe59a5d9b95f50264'
    )
  );

  runApp(const App());
}