import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/account/views/account_page.dart';
import 'package:t_learn/pages/dashboard/views/dashboard_page.dart';
import 'package:t_learn/pages/home/cubit/home_cubit.dart';
import 'package:t_learn/pages/quiz/views/quiz_main_page.dart';
import 'package:t_learn/pages/saved/views/saved_materials_page.dart';

import '../../../app/app.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<Widget> children = [
      const DashboardPage(),
      const QuizMainPage(),
      const SavedMaterialsPage(),
      const AccountPage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        const App().closeApp();
        return true;
      },
      child: BlocBuilder<HomeCubit,int>(
        builder: (_,state){
          return Scaffold(
              body: children[state],
              bottomNavigationBar: SizedBox(
                height: 60,
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.house),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.solidClipboard),
                      label: 'Quiz',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.solidHeart),
                      label: 'Saved',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.solidUser),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: state,
                  onTap: (index)=>BlocProvider.of<HomeCubit>(context).currentPageIndex(index),
                ),
              )
          );
        },
      )
    );
  }
}
