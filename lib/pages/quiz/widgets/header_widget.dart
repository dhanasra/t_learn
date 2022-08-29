import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/pages/quiz/widgets/simple_timer.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';

import '../bloc/quiz_bloc/quiz_bloc.dart';

class HeaderWidget extends StatelessWidget {
  final VoidCallback onSubmitted;
  const HeaderWidget({
    Key? key,
    required this.onSubmitted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
            ]
        ),
        child: BlocBuilder<QuizBloc, QuizState>(
            buildWhen: (previousState,state){
              return state is QuestionIndex;
            },
            builder: (_,state) {
              var currentIndex = 1;
              if (state is QuestionIndex) {
                currentIndex = state.index+1;
              }

              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("attempted",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                          .tr(),
                      Utils.dividerMedium,
                      const Text("time_left",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                          .tr()
                    ],
                  ),
                  Utils.verticalDivider,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$currentIndex / ${QuizViewModel.questions.length}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Utils.dividerMedium,
                        SimpleTimer(
                          timerController: (AnimationController controller) {
                            controller.forward();
                            controller.addStatusListener((status) {
                              if(status == AnimationStatus.completed){
                                showTimeUp(context);
                                Future.delayed(Utils.duration_1,(){
                                  const App().setBackNavigation(context);
                                  if(QuizViewModel.type=="today"){
                                    const App().setNavigation(context, AppRoutes.quizTodayResult);
                                  }else{
                                    const App().setNavigation(context, AppRoutes.quizResult);
                                  }
                                });
                              }
                            });
                          },
                          duration:  QuizViewModel.selectedTest!=null
                              ? int.parse(QuizViewModel.selectedTest!.duration) * 60
                              : QuizViewModel.questions.length * 60,
                        )
                      ],
                    ),
                  ),

                 if(currentIndex == QuizViewModel.questions.length) TextButton(
                      onPressed: () => showSubmitBottomSheet(context),
                      child: Row(
                        children: [
                          const Text("submit", style: TextStyle(fontSize: 16)).tr(),
                          const Icon(Icons.double_arrow_rounded)
                        ],
                      )
                  )
                ],
              );
            }));
  }

  void showSubmitBottomSheet(BuildContext context){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
            top: Radius.circular(25)),),
        backgroundColor: Theme.of(context).cardColor, context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Submit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                Utils.divider_50,
                const Text("Do you want to submit your test?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                Utils.dividerExtraLarge,
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: onSubmitted,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Utils.darkenColor(primaryColor),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: const Text( 'Yes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),).tr()
                          ),
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        child: GestureDetector(
                          onTap: ()=>const App().setBackNavigation(context),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Utils.darkenColor(primaryColor))
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Text( 'No', style: TextStyle(color: Utils.darkenColor(primaryColor), fontWeight: FontWeight.w500),).tr()
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  void showTimeUp(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_){
          return WillPopScope(
              onWillPop: () async => false,
              child: Center(
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer, color: primaryColor, size: 100,),
                      const SizedBox(height: 10,),
                      const Text("Oops ! Time's up !", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)).tr(),
                    ],
                  ),
                ),
              ));
        });
  }
}
