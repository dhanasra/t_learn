import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/quiz/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:t_learn/pages/quiz/model/chapter.dart';
import 'package:t_learn/pages/quiz/widgets/chapter_item.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/loading.dart';


class QuizTopicsPage extends StatelessWidget {
  const QuizTopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        isBackPressed: true,
        title: "Chapters",
        child: MainBody());
  }
}


class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc,QuizState>(
        builder: (_,state){
          if(state is ChaptersLoading){
            return const TopicsListBuilder(isLoading: true,);
          }else if(state is ChaptersFetched){
            return TopicsListBuilder(isLoading: false, chapter: state.chapter,);
          }else{
            return const SizedBox();
          }
        });
  }
}

class TopicsListBuilder extends StatelessWidget {
  final bool isLoading;
  final List<Chapter>? chapter;
  const TopicsListBuilder({Key? key, required this.isLoading, this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: isLoading ? 2 : chapter!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        itemBuilder: (_,index)=> isLoading
            ? Container(
            padding: const EdgeInsets.all(10),
            child: const Loading(type: shimmer_2))
            : ChapterItem(chapter: chapter![index],));
  }
}


