import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc/quiz_bloc.dart';

class PageIndicatorItem extends StatelessWidget {
  final int index;
  final VoidCallback onPressed;
  final bool isActive;

  const PageIndicatorItem({
    Key? key,
    required this.index,
    required this.onPressed,
    required this.isActive
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
        buildWhen: (previousState,state){
          return state is QuestionIndex;
        },
        builder: (_,state){
          var currentIndex = 0;
          if(state is QuestionIndex){
            currentIndex = state.index;
          }

          return Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: Colors.deepPurple),
                    color: currentIndex == index ? Colors.deepPurple : Colors.white
                ),
                child: InkWell(
                  onTap: onPressed,
                  child: Center(
                    child: Text(
                      "${index+1}",
                      style: TextStyle(
                          color: currentIndex == index ? Colors.white : Colors.deepPurple,
                          fontWeight: FontWeight.w600),
                    ),
                ),
              ));
        },
    );
  }
}
