import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/local_db.dart';

import '../../../utils/utils.dart';
import '../view_models/quiz_view_model.dart';

class DailyTestItem extends StatelessWidget {
  const DailyTestItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
          ]
      ),
      child: Row(
        children: [
          Expanded(child: Image.asset("${appAssets}daily_test.png")),
          Expanded(child: Column(
            children: [
              const Text("Attend Today's test",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
              Utils.divider,
              Text("The best preparation of tomorrow is doing your best today",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).canvasColor.withOpacity(0.6), fontSize: 12)).tr(),
              Utils.divider,
              GestureDetector(
                onTap: () {
                  QuizViewModel.answers = {};
                  QuizViewModel.type = "today";
                  const App().setNavigation(context, AppRoutes.quizToday);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Utils.darkenColor(primaryColor),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: const Text( 'Attend', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),).tr()
                )
              )
            ],
          ))
        ],
      ),
    );
  }
}
