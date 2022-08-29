import 'package:flutter/material.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/utils/utils.dart';

import '../../../app/app.dart';
import '../model/test.dart';

class QuizListItem extends StatelessWidget {
  final Test test;

  const QuizListItem({
    Key? key,
    required this.test
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 52,
              child: Text(test.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),

            Utils.dividerMedium,

            Text(test.subTag, style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600, fontSize: 12)),

            const Spacer(),

            Row(
              children: [
                Expanded(child: Text("Questions",
                  style: TextStyle(
                      color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12),),),
                Expanded(child: Text(test.noOfQuestions,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12))),
              ],
            ),

            Utils.dividerMedium,

            Row(
              children: [
                Expanded(child: Text("Marks",
                  style: TextStyle(
                      color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12),),),
                Expanded(child: Text("${test.marks} marks",
                    style: TextStyle(
                        color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12))),
              ],
            ),

            Utils.dividerMedium,

            Row(
              children: [
                Expanded(child: Text("Duration",
                  style: TextStyle(
                      color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12),),),
                Expanded(child: Text("${test.duration} mins",
                    style: TextStyle(
                        color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12))),
              ],
            ),

            const Spacer(),

            Align(
              alignment: Alignment.center,
              child: TextButton(onPressed: (){
                  QuizViewModel.selectedTest = test;
                  const App().setNavigation(context, AppRoutes.quizInfo);},
                  child: const Text("Attempt")),
            ),

          ],
        ),
    );
  }
}
