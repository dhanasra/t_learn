import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/widgets/background.dart';
import '../widgets/profile_option.dart';

class ExamSettings extends StatelessWidget {
  const ExamSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        isBackPressed: true,
        title: "Exam Settings",
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
        ProfileOption(icon: FontAwesomeIcons.penNib, option: "Change Exam",
            onClick: ()=> const App().setNavigation(context, AppRoutes.exam)
        )
      ],
    );
  }
}

