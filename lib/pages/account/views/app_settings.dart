import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/pages/account/bloc/theme/theme_bloc.dart';
import 'package:t_learn/pages/account/widgets/radio_item.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';

import '../widgets/profile_option.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        isBackPressed: true,
        title: "App Settings",
        padding: EdgeInsets.all(20),
        child: MainBody());
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOption(icon: FontAwesomeIcons.themeco, option: "Change Theme", onClick: ()=>showThemeSheet(context)),
        ProfileOption(icon: FontAwesomeIcons.language, option: "Change App Language", onClick: ()=>showLanguageSheet(context)),
      ],
    );
  }

  showLanguageSheet(BuildContext context){

    showModalBottomSheet(
      shape: const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(
          top: Radius.circular(25) ),),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Select Language", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),).tr(),
              contentPadding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            ),

            Utils.divider,

            RadioItem(value: "ta_IN", gValue: Globals.language, onValueChange: (val){
              Globals.language = "ta_IN";
              context.setLocale((const Locale("ta")));
              BlocProvider.of<ThemeBloc>(context).add(UpdateLanguage(lang: "ta_IN"));
              const App().setBackNavigation(context);
            }, text: "Tamil"),

            RadioItem(value: "en_US", gValue: Globals.language, onValueChange: (val){
              Globals.language = "en_US";
              context.setLocale((const Locale("en")));
              BlocProvider.of<ThemeBloc>(context).add(UpdateLanguage(lang: "en_US"));
              const App().setBackNavigation(context);
            }, text: "English")

          ],
        );
      },
    );
  }

  showThemeSheet(BuildContext context){

    showModalBottomSheet(
      shape: const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(
          top: Radius.circular(25) ),),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Select Theme", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),).tr(),
              contentPadding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            ),

            Utils.divider,

            RadioItem(value: "lightTheme", gValue: Globals.theme, onValueChange: (val){
              Globals.theme = "lightTheme";
              BlocProvider.of<ThemeBloc>(context).add(UpdateTheme(theme: "lightTheme"));
              const App().setBackNavigation(context);
            }, text: "Light Theme"),

            RadioItem(value: "darkTheme", gValue: Globals.theme, onValueChange: (val){
              Globals.theme = "darkTheme";
              BlocProvider.of<ThemeBloc>(context).add(UpdateTheme(theme: "darkTheme"));
              const App().setBackNavigation(context);
            }, text: "Dark Theme")

          ],
        );
      },
    );
  }
}

