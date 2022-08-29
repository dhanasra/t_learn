import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:t_learn/pages/practice/bloc/practice_bloc.dart';
import 'package:t_learn/pages/practice/view_model/practice_view_model.dart';
import 'package:t_learn/pages/quiz/model/question.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/loading.dart';

import '../../../utils/utils.dart';
import '../../../widgets/admob.dart';
import '../../../widgets/background.dart';

final BannerAd myBanner = BannerAd(
  adUnitId: Admob.bannerId3,
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);

const AdSize adSize = AdSize(height: 50, width: 300);

class PracticePage extends StatelessWidget {
  const PracticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    myBanner.load();

    return Background(
        isBackPressed: true,
        title: PracticeViewModel.selectedExam!.name,
        child: const MainBody()
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticeBloc, PracticeState>(
        builder: (_,state){
          if(state is QuestionsLoading){
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Loading(type: shimmer_1),);
          }else if(state is QuestionsFetched){
            return QuestionsBuilder(questions: state.questions,);
          }else{
            return const SizedBox();
          }
        });
  }
}

class QuestionsBuilder extends StatelessWidget {
  final List<Question> questions;
  final AdWidget adWidget = AdWidget(ad: myBanner);

  QuestionsBuilder({
    Key? key,
    required this.questions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PracticeViewModel viewModel = PracticeViewModel();

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
          child: adWidget,
        ),
        Expanded(child: PageView.builder(
            itemBuilder: (_,index){
              return ListView(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Question: ${index+1}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 2))),

                  Utils.dividerLarge,

                  if(questions[index].questionImg!=null) Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.network(questions[index].questionImg!),
                  ),

                  if(questions[index].questionImg!=null) Utils.dividerLarge,

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(questions[index].question, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 2))),

                  Utils.dividerLarge,

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text("Answer", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 2)).tr()),

                  Utils.divider,

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(viewModel.getAnswer(questions[index]), textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 2))),

                  Utils.dividerLarge,

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text("Explanation", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 2)).tr()),

                  Utils.divider,

                  if(questions[index].explanationImg!=null) Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.network(questions[index].explanationImg!),
                  ),

                  Utils.divider,

                  if(questions[index].explanation!=null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(questions[index].explanation!, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 2))),

                  if(questions[index].explanation==null && questions[index].explanationImg==null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text("No explanations available", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 2)).tr()),

                ],
              );
            }))
      ],
    );
  }
}


