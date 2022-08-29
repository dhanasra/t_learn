import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/quiz/model/exam.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/utils/utils.dart';

class QuizMainItem extends StatelessWidget {

  final Exam exam;

  const QuizMainItem({
    Key? key,
    required this.exam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          QuizViewModel.type = "test";
          QuizViewModel.answers = {};
          QuizViewModel.selectedExam = exam;
          const App().setNavigation(context, AppRoutes.quizChapters);
        },
        child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
            ]
        ),
        child: Column(
            children: [
              Expanded(child: CachedNetworkImage(imageUrl: exam.icon)),
              Utils.divider,
              Text(exam.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10
                ),),
            ],
      ),
    ));
  }
}
