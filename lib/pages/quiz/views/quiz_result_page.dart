import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/quiz/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:t_learn/pages/quiz/model/result.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/pages/quiz/widgets/quiz_result_item.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/date_utils.dart';
import 'package:t_learn/utils/utils.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../widgets/background.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Background(
          isBackPressed: true,
          onBackPress: ()=>const App().setNavigation(context, AppRoutes.home),
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.chartSimple, size: 26),
              onPressed: ()=>const App().setNavigation(context, AppRoutes.analysis),
              splashRadius: 20,
            ),
          ],
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<QuizBloc, QuizState>(
              builder: (_,state){
                if(state is QuizResultLoading){
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2,),
                  );
                }else if(state is QuizResult){
                  return MainBody(result: state.result,);
                }else{
                  return const SizedBox();
                }
              }),
        ),
        onWillPop: ()async{
          const App().setNavigation(context, AppRoutes.home);
          return false;
        });
  }
}

class MainBody extends StatelessWidget {
  final Result result;
  const MainBody({
    Key? key,
    required this.result
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text("SCORECARD", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)).tr(),

        Utils.dividerLarge,

        Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${result.correct}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 40)),
                    const SizedBox(width: 5,),
                    Text("/ ${QuizViewModel.questions.length}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 28))
                  ]
                ),
                Text("total_marks", style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr()
              ],
            ),),

            Expanded(child: Column(
              children: [
                QuizResultItem(content: "correct", icon: FontAwesomeIcons.check, iconColor: Colors.green, noOfQuestions: "${result.correct}"),
                QuizResultItem(content: "incorrect", icon: FontAwesomeIcons.x, iconColor: Colors.red, noOfQuestions: "${result.incorrect}"),
                QuizResultItem(content: "unattempted", icon: FontAwesomeIcons.question, iconColor: Colors.grey, noOfQuestions: "${result.unattempted}"),
              ],
            )),
          ],
        ),

        Utils.divider_50,

        ListTile(
          leading: Icon(FontAwesomeIcons.percent, size: 22, color: Theme.of(context).iconTheme.color,),
          title: const Text("percentage", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
          subtitle: Text("Your percentage is very low", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Theme.of(context).canvasColor.withOpacity(0.6))),
          trailing: Text(result.percentage, style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16)),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.clock, size: 22, color: Theme.of(context).iconTheme.color,),
          title: const Text("time_taken", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
          subtitle: Text("You are taking too much time", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Theme.of(context).canvasColor.withOpacity(0.6))),
          trailing: Text(DateTimeUtils.getTimerFormat2(result.timeTaken), style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16)),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.eye, size: 22, color: Theme.of(context).iconTheme.color,),
          title: const Text("accuracy", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
          subtitle: Text("Your accuracy is very low", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Theme.of(context).canvasColor.withOpacity(0.6))),
          trailing: Text(result.accuracy, style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16)),
        ),

        Utils.dividerLarge,

        Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: ()=>const App().setNavigation(context, AppRoutes.quizSolutions),
              child: const Text("view_solutions").tr()),
        ),

        const Spacer(),

        ElevatedButton(
          onPressed: () =>const App().setNavigation(context, AppRoutes.home),
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50),),
          child: const Text('Go to Home').tr())
      ],
    );
  }
}

