import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/widgets/background.dart';

import '../../../utils/utils.dart';
import '../../../utils/widgets/constants.dart';
import '../../../widgets/loading.dart';
import '../../quiz/model/exam.dart';
import '../bloc/practice_bloc.dart';
import '../widgets/practice_main_item.dart';

class PracticeMainPage extends StatelessWidget {
  const PracticeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        isBackPressed: true,
        title: "Practice",
        child: MainBody());
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text("Practice Questions",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
        ),

        Utils.dividerSmall,

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Practice before perform",
                style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr()
        ),

        Utils.divider,

        BlocBuilder<PracticeBloc,PracticeState>(
            buildWhen: (_,state)=>state is SubjectsLoading || state is SubjectsFetched,
            builder: (_,state){
              if(state is SubjectsLoading){
                return const PracticeGrid(isLoading: true);
              }else if(state is SubjectsFetched){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: PracticeGrid(isLoading: false, exams: state.exams,),);
              }else{
                return const SizedBox();
              }
            }),

      ],
    );
  }
}

class PracticeGrid extends StatelessWidget {
  final bool isLoading;
  final List<Exam>? exams;

  const PracticeGrid({
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
              padding: EdgeInsets.all(15),
              child: Loading(type: shimmer_2))
              : PracticeMainItem(exam: exams![index],);
        }
    );
  }
}