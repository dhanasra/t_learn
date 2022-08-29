import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/quiz/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:t_learn/pages/quiz/model/test.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/pages/quiz/widgets/quiz_list_item.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/loading.dart';

import '../../../app/app.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({Key? key}) : super(key: key);

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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(QuizViewModel.selectedChapter!.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
                  Utils.divider,
                  Text(QuizViewModel.selectedExam!.name,
                      style: const TextStyle(color: Colors.deepPurple, fontSize: 14, fontWeight: FontWeight.w600))
                ],
              )),
              CachedNetworkImage(imageUrl: QuizViewModel.selectedExam!.icon, width: 60),
            ],
          ),
        ),

        Utils.dividerSmall,

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text("trending_mock_tests", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr()
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text("students_attended",
            style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr(),
        ),

        Utils.dividerMedium,

        SizedBox(
          height: 265,
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (_,state){
              if(state is TestListLoading){
                return const QuizListBuilder(isLoading: true);
              }else if(state is TestListFetched){
                return QuizListBuilder(isLoading: false, tests: state.tests);
              }else{
                return const SizedBox();
              }
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: const Text("faqs", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr()
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
              ]
          ),
          child: Row(
            children: [
              Expanded(
                child: const Text("support_1",
                  style: TextStyle(fontWeight: FontWeight.w600, height: 2, fontSize: 12)).tr()),
              TextButton(onPressed: (){}, child: const Text("send").tr())
            ],
          ),
        )
      ],
    );
  }
}

class QuizListBuilder extends StatelessWidget {
  final bool isLoading;
  final List<Test>? tests;
  const QuizListBuilder({Key? key, required this.isLoading, this.tests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: isLoading ? 2 : tests!.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (_,index)=> isLoading
            ? Container(
              width: 200,
              padding: const EdgeInsets.all(10),
              child: const Loading(type: shimmer_3))
            : QuizListItem(test: tests![index]));
  }
}

