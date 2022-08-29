import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/materials/model/notes_item.dart';
import 'package:t_learn/pages/materials/view_models/material_view_model.dart';
import 'package:t_learn/pages/quiz/model/chapter.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';

import '../../../utils/globals.dart';

class ChapterItem extends StatelessWidget {
  final Chapter chapter;
  const ChapterItem({
    Key? key,
    required this.chapter
  }) : super(key: key);

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
      child: InkWell(
        onTap: (){
          QuizViewModel.selectedChapter = chapter;
          if(chapter.isPrime){
            if(Globals.isPrime){
              const App().setNavigation(context, AppRoutes.quizList);
            }else{
              const App().setNavigation(context, AppRoutes.subscription);
            }
          }else{
            const App().setNavigation(context, AppRoutes.quizList);
          }
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: Utils.getRandomColor(),
                child: Center(
                  child: Text(chapter.name.substring(0,1)),
                ),
              ),
            ),
            Utils.verticalDividerMedium,
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chapter.name,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, height: 1.5)),
                    Utils.divider,
                    Row(
                      children: [
                        Text("${chapter.noOfQuestions}+ Questions", style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6)),),
                        const Spacer(),
                        if(chapter.isPrime)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.deepOrange.withOpacity(0.4)),
                                color: Colors.orangeAccent.withOpacity(0.1)
                            ),
                            child: const Text("Prime",
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10, height: 1.5, color: Colors.deepOrange)),
                          ),
                      ],
                    ),
                  ],
                )
            )
          ],
        )
      ),
    );
  }
}
