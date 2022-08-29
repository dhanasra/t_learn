import 'package:flutter/material.dart';
import 'package:t_learn/pages/quiz/model/question.dart';
import 'package:t_learn/pages/quiz/widgets/radio_option_item.dart';
import 'package:t_learn/utils/utils.dart';

class QuestionItem extends StatelessWidget {

  final Question question;

  const QuestionItem({
    Key? key,
    required this.question
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          if(question.questionImg!=null) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.network(question.questionImg!),
          ),

          if(question.questionImg!=null) Utils.dividerLarge,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(question.question, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 2))),

          Utils.divider_50,

          RadioOptionItem(option: question.option1, optionIndex: "A",),
          RadioOptionItem(option: question.option2, optionIndex: "B",),
          RadioOptionItem(option: question.option3, optionIndex: "C",),
          RadioOptionItem(option: question.option4, optionIndex: "D",),

        ],
      ),
    );
  }
}
