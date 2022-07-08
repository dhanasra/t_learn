import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/custom_app_bar.dart';
import '../widgets/profile_option.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CustomAppBar.leadingIcon(),
          title: CustomAppBar.title("App Settings"),
          actions: [ CustomAppBar.actionIcon(Icons.segment,(){}) ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.deepPurpleAccent,
        ),
        backgroundColor: Colors.white,
        body: const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 20),
          child: MainBody(),
        )
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOption(icon: FontAwesomeIcons.themeco, option: "Change Theme", onClick: (){}),
        ProfileOption(icon: FontAwesomeIcons.language, option: "Change App Language", onClick: (){}),
        ProfileOption(icon: FontAwesomeIcons.powerOff, option: "Enable Offline Mode", onClick: (){}),
      ],
    );
  }
}

