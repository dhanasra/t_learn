import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/analysis/bloc/analysis_bloc.dart';
import 'package:t_learn/pages/analysis/widgets/bar_chart_item.dart';
import 'package:t_learn/pages/analysis/widgets/line_chart_item.dart';
import 'package:t_learn/pages/analysis/widgets/pie_chart_item.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/loading.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        isBackPressed: true,
        title: "Analysis",
        child: MainBody());
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [

        const Text("Overall performance",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),

        Utils.dividerSmall,

        Text("Analyze & Improve your score",
            style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr(),

        Utils.divider_50,

        BlocBuilder<AnalysisBloc, AnalysisState>(
            buildWhen: (_,state)=> state is OverAllScoresLoading || state is OverAllScoresFetched,
            builder: (_,state){
              if(state is OverAllScoresLoading){
                return const Loading(type: shimmer_1);
              }else if(state is OverAllScoresFetched){
                return Row(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChartItem(
                        correct: state.analysis.correct,
                        wrong: state.analysis.incorrect,
                        unAttempted: state.analysis.unattempted,
                      ),
                    ),
                    Expanded(child: Column(
                      children: [
                        const Text("Over All Score",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                        Utils.dividerSmall,
                        Text(state.analysis.correct,textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 40, color: primaryColor),),
                        Utils.dividerSmall,
                        Text("Based on all of your test scores",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Theme.of(context).canvasColor.withOpacity(0.6)),),
                      ],
                    ))
                  ],
                );
              }else{
                return const SizedBox();
              }
            }
        ),

        Utils.divider_50,

        const Text("Test performance",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),

        Utils.dividerSmall,

        Text("Analyze & Improve your score",
            style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr(),

        Utils.divider_50,


        BlocBuilder<AnalysisBloc, AnalysisState>(
            buildWhen: (_,state)=> state is TestScoresLoading || state is TestScoresFetched,
            builder: (_,state){
              if(state is TestScoresLoading){
                return const Loading(type: shimmer_1);
              }else if(state is TestScoresFetched){
                return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: BarChartItem(results: state.result),
                    )
                );
              }else{
                return const SizedBox();
              }
            }
        ),

        Utils.divider_50,

        const Text("Overall accuracy",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),

        Utils.dividerSmall,

        Text("Analyze & Improve your accuracy",
            style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr(),

        Utils.divider,

        BlocBuilder<AnalysisBloc, AnalysisState>(
            buildWhen: (_,state)=> state is TestScoresLoading || state is TestScoresFetched,
            builder: (_,state){
              if(state is TestScoresLoading){
                return const Loading(type: shimmer_1);
              }else if(state is TestScoresFetched){
                return SizedBox(
                  height: 400,
                  child: LineChartItem(results: state.result),
                );
              }else{
                return const SizedBox();
              }
            }
        ),
      ],
    );
  }
}
