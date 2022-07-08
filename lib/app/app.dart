import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:t_learn/pages/account/views/account_page.dart';
import 'package:t_learn/pages/account/views/app_settings.dart';
import 'package:t_learn/pages/account/views/edit_profile.dart';
import 'package:t_learn/pages/account/views/exam_settings.dart';
import 'package:t_learn/pages/account/views/my_profile.dart';
import 'package:t_learn/pages/auth/views/landing_page.dart';
import 'package:t_learn/pages/auth/views/login_page.dart';
import 'package:t_learn/pages/chat/views/chat_page.dart';
import 'app_routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return getMaterialApp(widget: user==null ? const LoginPage() : const ChatPage() , title: 'Launch', buildContext: context);
  }

  AppRoutes getAppRoutes() {
    return AppRoutes();
  }

  Widget getMaterialApp({required Widget widget, required String title, required BuildContext buildContext}) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins').copyWith(
        inputDecorationTheme: const InputDecorationTheme().copyWith(
            fillColor: Colors.grey.withOpacity(0.2)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:  MaterialStateProperty.all(Colors.deepPurple)
          )
        )
      ),
      home: widget,
    );
  }

  Future<dynamic> setNavigation(BuildContext context, String appRouteName) async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final info = await Navigator.push(
          context,
          PageTransition(
              child: getAppRoutes().getWidget(context, appRouteName),
              type: PageTransitionType.fade,
              settings: RouteSettings(name: appRouteName),
              duration: const Duration(microseconds: 0))
      );
      return info;
    });
  }

  void setBackNavigation(BuildContext context) {
    Navigator.pop(context, "true");
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }

}
