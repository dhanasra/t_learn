import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/quiz/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:t_learn/pages/quiz/widgets/quiz_info_item.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';

import '../view_models/quiz_view_model.dart';

class QuizInfoPage extends StatelessWidget {
  const QuizInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        isBackPressed: true,
        padding: EdgeInsets.all(20),
        child: MainBody()
      );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            CachedNetworkImage(imageUrl: QuizViewModel.selectedExam!.icon, width: 60),
            Expanded(
                child: Text(QuizViewModel.selectedTest!.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                )
            ),
          ],
        ),

        Utils.divider_50,

        Row(
          children: [
            QuizInfoItem(infoIcon: Icons.post_add, infoKey: "questions", infoValue: QuizViewModel.selectedTest!.noOfQuestions),
            Container(height: 80,width: 1, color: Colors.grey.withOpacity(0.4),),
            QuizInfoItem(infoIcon: Icons.timer_outlined, infoKey: "duration", infoValue: QuizViewModel.selectedTest!.duration),
            Container(height: 80,width: 1, color: Colors.grey.withOpacity(0.4),),
            QuizInfoItem(infoIcon: Icons.check_circle_outline, infoKey: "marks", infoValue: QuizViewModel.selectedTest!.marks),
          ],
        ),

        Utils.divider_50,

        const Text("instructions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)).tr(),

        Utils.dividerMedium,

        Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("info_1", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)).tr(),
                Utils.dividerMedium,
                const Text("info_2", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)).tr(),
                Utils.dividerMedium,
                const Text("info_3", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)).tr(),
                Utils.dividerMedium,
                const Text("info_4", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)).tr(),
              ],
            ),
        ),

        const Spacer(),

        BlocBuilder<QuizBloc,QuizState>(
            builder: (_,state){
              if(state is QuestionsFetchLoading){
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(strokeWidth: 2,),
                );
              }else if(state is QuestionsFetched){
                QuizViewModel.questions = state.questions;
                return ElevatedButton(
                    onPressed: () =>const App().setNavigation(context, AppRoutes.quizGame),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50),),
                    child: const Text('start_test').tr());
              }else{
                return const SizedBox();
              }
            })
      ],
    );
  }
}

