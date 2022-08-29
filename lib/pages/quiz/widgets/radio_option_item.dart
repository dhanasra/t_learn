import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/quiz/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';

class RadioOptionItem extends StatelessWidget {
  final String option;
  final String optionIndex;
  const RadioOptionItem({
    Key? key,
    required this.option,
    required this.optionIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc,QuizState>(
        buildWhen: (previousState, state){
          return state is OptionSelected;
        },
        builder: (_,state){

          var selectedOption = QuizViewModel.answers[QuizViewModel.currentQuestionIndex];

          if(state is OptionSelected){
            selectedOption = state.option;
          }

          return GestureDetector(
              onTap: ()=>BlocProvider.of<QuizBloc>(context).add(OptionSelectEvent(option: optionIndex, questionIndex: 1)),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(4)
                    ),
                    border: Border.all(
                        color: Colors.deepPurple.withOpacity(selectedOption==optionIndex ? 1 : 0.2),
                    )
                ),
                child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.deepPurple.withOpacity(selectedOption==optionIndex ? 1 : 0.2),
                        child: Text(optionIndex, style: TextStyle(color: selectedOption==optionIndex ? Colors.white : Colors.deepPurple, fontSize: 14, fontWeight: FontWeight.w600))
                      ),
                      const SizedBox(width: 10,),
                      Flexible(child: Text(option, style:const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)))
                    ],
            ))
          );
        });
  }
}
