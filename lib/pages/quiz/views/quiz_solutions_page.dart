import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';

import '../../../app/app.dart';

class QuizSolutionsPage extends StatelessWidget {
  const QuizSolutionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      isBackPressed: true,
      child: MainBody()
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: QuizViewModel.questions.length,
      itemBuilder: (_,index){
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Question ${index+1}", style:const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Utils.dividerMedium,
                    if(QuizViewModel.questions[index].questionImg!=null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.network(QuizViewModel.questions[index].questionImg!),
                    ),
                    if(QuizViewModel.questions[index].questionImg!=null) Utils.dividerMedium,
                    Text(QuizViewModel.questions[index].question, style:const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    Utils.dividerLarge,
                    Text("A. ${QuizViewModel.questions[index].option1}", style:const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    Utils.dividerMedium,
                    Text("B. ${QuizViewModel.questions[index].option2}", style:const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    Utils.dividerMedium,
                    Text("C. ${QuizViewModel.questions[index].option3}", style:const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    Utils.dividerMedium,
                    Text("D. ${QuizViewModel.questions[index].option4}", style:const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    Utils.dividerLarge,
                    Row(
                      children: [
                        Text("Answer : ${QuizViewModel.questions[index].answer}", style:const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        const Spacer(),
                        Text("Mark : ${
                            QuizViewModel.answers[index+1]!=null
                                ? QuizViewModel.answers[index] == QuizViewModel.questions[index].answer
                                ? "+4" : "-1" : "0"}", style:
                        TextStyle(
                            color: QuizViewModel.answers[index+1]!=null
                                ? QuizViewModel.answers[index] == QuizViewModel.questions[index].answer
                                ? Colors.green : Colors.red : primaryColor,
                            fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                    const Text("Explanation", style:TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),

                    Utils.divider,

                    if(QuizViewModel.questions[index].explanationImg!=null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.network(QuizViewModel.questions[index].explanationImg!),
                    ),

                    if(QuizViewModel.questions[index].explanation!=null) Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(QuizViewModel.questions[index].explanation!,
                            textAlign: TextAlign.center,
                            style:const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),

                    if(QuizViewModel.questions[index].explanation==null && QuizViewModel.questions[index].explanationImg==null) Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text("No explanations available",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)).tr()),
                 ],
                )),
              ],
            ),
            const Divider(height: 50,)
          ],
        );
      },
    );
  }
}

