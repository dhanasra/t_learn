import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/quiz/bloc/today_bloc/quiz_today_bloc.dart';
import 'package:t_learn/pages/quiz/model/todayTest.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/loading.dart';

import '../../../utils/constants.dart';

class QuizTodayPage extends StatelessWidget {
  const QuizTodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        isBackPressed: true,
        title: "Today's test",
        child: BlocListener<QuizTodayBloc, QuizTodayState>(
            listenWhen: (_,state)=>state is QuestionsFetched,
            listener: (_,state){
              if(state is QuestionsFetched){
                QuizViewModel.questions = state.questions;
                QuizViewModel.type = "today";
                const App().setNavigation(context, AppRoutes.quizGame);
              }
            },
            child: const MainBody(),
        ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizTodayBloc, QuizTodayState>(
        buildWhen: (_, state)=> state is TodayQuizInfo || state is QuizTodayInitial,
        builder: (_,state){
          if(state is TodayQuizInfo){
            return QuizInfoBuilder(test: state.test);
          }else{
            return const Loading(type: shimmer_1);
          }
        });
  }
}

class QuizInfoBuilder extends StatelessWidget {

  final TodayTest test;
  const QuizInfoBuilder({
    Key? key,
    required this.test
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Table(
          border:TableBorder.all(width: 1.0,color: primaryColor),
          children: [
            TableRow(
                children: [
                  const Padding(padding: EdgeInsets.all(10),child: Text("Exam"),),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(test.exam),
                  ),
                ]
            ),

            TableRow(
                children: [
                  const Padding(padding: EdgeInsets.all(10),child: Text("Date"),),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(test.date),
                  ),
                ]
            ),

            ...test.noOfQuestions.keys.map((e) => TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10),child: Text(e),),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(test.noOfQuestions[e]!),
                  ),
                ]
            )).toList(),

            TableRow(
                children: [
                  const Padding(padding: EdgeInsets.all(10),child: Text("Marks"),),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(test.marks),
                  ),
                ]
            ),
          ],
        ),

        Utils.divider_50,

        BlocBuilder<QuizTodayBloc,QuizTodayState>(
            builder: (_,state){
              return ElevatedButton(
                  onPressed: state is PreparingQuestions
                      ? null
                      : ()=> BlocProvider.of<QuizTodayBloc>(context).add(
                      PrepareQuestions(test: test)),
                  style: ElevatedButton.styleFrom( minimumSize: const Size(double.infinity, 50)),
                  child: state is! PreparingQuestions ? const Text( 'Start').tr() : Utils.buttonProgressIndicator
              );
            }),

      ],
    );
  }
}


