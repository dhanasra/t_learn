import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/pages/quiz/widgets/daily_test_item.dart';
import 'package:t_learn/pages/quiz/widgets/quiz_main_item.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/loading.dart';

import '../../../utils/constants.dart';
import '../../kbc/widgets/common/border_container.dart';
import '../../kbc/widgets/common/border_text.dart';
import '../bloc/quiz_bloc/quiz_bloc.dart';
import '../model/exam.dart';

class QuizMainPage extends StatelessWidget {
  const QuizMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Background(
          isBackPressed: true,
            title: "Quiz",
            onBackPress: (){
              const App().closeApp();
            },
            actions: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.scroll, size: 26),
                onPressed: ()=>const App().setNavigation(context, AppRoutes.practiceMain),
                splashRadius: 20,
              ),
            ],
            child: BlocProvider(
              create: (_)=>QuizBloc()..add(GetMainExamsEvent())..add(GetMainSubjectsEvent())..add(CheckTodayTest()),
              child: const MainBody(),
            )
        ),
        onWillPop: ()async{
          const App().closeApp();
          return false;
        }
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [

        BlocBuilder<QuizBloc,QuizState>(
            buildWhen: (_,state)=>state is Checking || state is Checked,
            builder: (_,state){
              if(state is Checking){
                return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Loading(type: shimmer_2));
              }else if(state is Checked){
                if(state.isValid){
                  return const DailyTestItem();
                }else{
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
                        QuizViewModel.type = "result";
                        const App().setNavigation(context, AppRoutes.quizTodayResult);
                      },
                      child: Row(
                        children: [
                          Image.asset("${appAssets}daily_test.png", height: 100,),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Daily Test",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Utils.darkenColor(primaryColor)
                                  )).tr(),

                                  Utils.dividerSmall,

                                  Text("Check your rank for today's test",style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Theme.of(context).canvasColor
                                  )).tr(),

                                  Utils.dividerLarge,

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Utils.darkenColor(primaryColor),
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: const Text( 'Result', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),).tr(),

                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  );
                }
              }else{
                return const SizedBox();
              }
            }),

        Utils.dividerExtraLarge,

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text("Subject wise quiz",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
        ),

        Utils.dividerSmall,

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("2000+ questions",
                style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr()
        ),

        Utils.divider,

        BlocBuilder<QuizBloc,QuizState>(
            buildWhen: (_,state)=>state is QuizMainSubjectsLoading || state is QuizMainSubjectsFetched,
            builder: (_,state){
              if(state is QuizMainSubjectsLoading){
                return const QuizExamsGrid(isLoading: true);
              }else if(state is QuizMainSubjectsFetched){
                return QuizExamsGrid(isLoading: false, exams: state.exams,);
              }else{
                return const SizedBox();
              }
            }),

        Utils.dividerExtraLarge,

        Divider(color: Colors.grey.withOpacity(0.1),thickness: 8,),

        Utils.divider,

        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              gradient: appGradient,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
              ]
          ),
            child: InkWell(
                onTap: ()=>const App().setNavigation(context, AppRoutes.analysis),
                child: Column(
                  children: [
                    const BorderedText(text: "Trivia", strokeColor: Colors.white,offset: 0,fontSize: 45,),
                    const BorderedText(text: "Master", strokeColor: Colors.white,offset: 0,fontSize: 45,),
                    Utils.dividerLarge,
                    Image.asset('${appAssets}money_bag.png'),
                    const Text("Play game and earn coins!!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      ),),
                    Utils.dividerLarge,
                    GestureDetector(
                      child: const CircleContainer(
                          width:  120,
                          height: 50,
                          child: Text("Play",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ))),
                      onTap: ()=>const App().setNavigation(context, AppRoutes.kbcMain),
                    )
                  ],
                ),
            )
        ),

        Utils.divider,

        Container(
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
            onTap: ()=>const App().setNavigation(context, AppRoutes.analysis),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Test Analysis",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Utils.darkenColor(primaryColor)
                        )),

                        Utils.dividerSmall,

                        Text("Charts & graph of test results",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Theme.of(context).canvasColor
                        )),

                        Utils.dividerLarge,

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Utils.darkenColor(primaryColor),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: const Text( 'View Analysis', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),).tr(),

                        )
                      ],
                    )),
                Image.asset("${appAssets}analysis.png", height: 100,)
              ],
            ),
          ),
        ),

        Utils.divider,

        Divider(color: Colors.grey.withOpacity(0.1),thickness: 8,),

        Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: ()=>QuizViewModel.openMail(),
              child: Row(
              children: [
                Expanded(child: Text("Any queries ? Feel free to reach us",
                    style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr()),
                Container(
                    decoration: BoxDecoration(
                        color: Utils.darkenColor(primaryColor),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: const Text( 'Send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),).tr()
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class QuizExamsGrid extends StatelessWidget {
  final bool isLoading;
  final List<Exam>? exams;

  const QuizExamsGrid({
    Key? key,
    required this.isLoading,
    this.exams
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 10),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: isLoading ? 3 : exams!.length,
        itemBuilder: (_,index){
          return isLoading
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: Loading(type: shimmer_2))
              : QuizMainItem(exam: exams![index],);
        }
    );
  }
}
