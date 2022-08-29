import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:t_learn/app/app_style.dart';
import 'package:t_learn/pages/account/bloc/theme/theme_bloc.dart';
import 'package:t_learn/pages/kbc/views/kbc_main_page.dart';
import '../pages/splash/views/splash_page.dart';
import 'app_routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getMaterialApp(widget: const SplashPage() , title: 'Launch', buildContext: context);
  }

  AppRoutes getAppRoutes() {
    return AppRoutes();
  }

  Widget getMaterialApp({required Widget widget, required String title, required BuildContext buildContext}) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>ThemeBloc(context: buildContext))
        ],
        child: BlocBuilder<ThemeBloc,ThemeState>(
            builder: (_,state){
              return MaterialApp(
                title: title,
                debugShowCheckedModeBanner: false,
                theme: state is ThemeFetched
                        ? state.theme=="lightTheme"
                          ? AppStyle.lightTheme(buildContext)
                          : AppStyle.darkTheme(buildContext)
                      : AppStyle.lightTheme(buildContext),
                home: widget,
                locale: buildContext.locale,
                localizationsDelegates: buildContext.localizationDelegates,
                supportedLocales: buildContext.supportedLocales,
                onGenerateRoute: getAppRoutes().getRoutes,
              );
            },
        ));
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

  void restart(context){
    const App().setNavigation(context, AppRoutes.splash);
  }

}
