import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/quiz/bloc/today_bloc/quiz_today_bloc.dart';
import 'package:t_learn/pages/quiz/model/result.dart';
import 'package:t_learn/pages/quiz/widgets/leader_board_card.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/constants.dart';
import '../../../widgets/background.dart';
import '../../../widgets/loading.dart';
import '../view_models/quiz_view_model.dart';
import '../widgets/quiz_result_item.dart';

class QuizTodayResult extends StatelessWidget {
  const QuizTodayResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Background(
          isBackPressed: true,
          onBackPress: ()=>const App().setNavigation(context, AppRoutes.home),
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<QuizTodayBloc, QuizTodayState>(
              buildWhen: (_,state)=> state is ResultLoading || state is ResultFetched,
              builder: (_,state){
                if(state is ResultLoading){
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2,),
                  );
                }else if(state is ResultFetched){
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
    return ListView(
      children: [
        const Text("SCORECARD", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)).tr(),

        Utils.dividerLarge,

        if(QuizViewModel.type=="today")
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

        if(QuizViewModel.type=="today")
        Utils.divider_50,

        BlocBuilder<QuizTodayBloc,QuizTodayState>(
            buildWhen: (_,state)=>state is LeaderBoardLoading || state is LeaderBoardFetched,
            builder: (_,state){
              if(state is LeaderBoardLoading){
                return const LeaderBoardBuilder(isLoading: true);
              }else if(state is LeaderBoardFetched){
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Text("Your Rank", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                    Text(state.myRank, style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),textAlign: TextAlign.center),
                    Text("score ${state.score}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Theme.of(context).canvasColor), textAlign: TextAlign.center,),
                    LeaderBoardBuilder(isLoading: false, toppers: state.toppers)
                  ],
                );
              }else{
                return const SizedBox();
              }
            }),

      ],
    );
  }
}

class LeaderBoardBuilder extends StatelessWidget {
  final bool isLoading;
  final List? toppers;
  const LeaderBoardBuilder({
    Key? key,
    required this.isLoading,
    this.toppers
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: isLoading ? 2 : toppers!.length <= 10? toppers!.length : 10,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemBuilder: (_,index)=> isLoading
            ? Container(
            padding: const EdgeInsets.all(10),
            child: const Loading(type: shimmer_2))
            : LeaderBoardCard(
              name: toppers![index]["uName"],
              photo: toppers![index]["uPhoto"],
              score: toppers![index]["score"].toString(),
              accuracy: toppers![index]["accuracy"],
              rank: "${index+1}",
            )
    );
  }
}


