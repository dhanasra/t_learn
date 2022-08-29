import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/auth/bloc/exam/exam_bloc.dart';
import 'package:t_learn/pages/auth/view_models/auth_view_model.dart';
import 'package:t_learn/pages/auth/widgets/exam_item.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/loading.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/background.dart';
import '../../../widgets/toaster.dart';
import '../model/course.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExamBloc, ExamState>(
        listenWhen: (_,state) {
          return state is ExamUpdated || state is Exception;
        },
        listener: (context, state) {
          if(state is ExamUpdated) const App().setNavigation(context, AppRoutes.setupLoading);
          if(state is Exception) {
            ScaffoldMessenger.of(context).showSnackBar(Toaster.snack(content: "Try again."));
          }
        },
        child: const Background(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: MainBody(),
        )
    );
  }
}

final isCourseSelected = ValueNotifier<bool>(false);

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text("Exam to prepare", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30,)).tr(),
        ),

        Utils.dividerMedium,

        Expanded(
            child: BlocBuilder<ExamBloc, ExamState>(
              buildWhen: (_,state)=>state is ExamLoading || state is ExamsFetched,
              builder: (_,state){
                return ExamsListBuilder(
                  isLoading: state is! ExamsFetched,
                  courses: state is ExamsFetched ? state.courses : null,
                );
              },
            )
        ),

        BlocBuilder<ExamBloc, ExamState>(
            buildWhen: (_,state)=>state is ExamSelected,
            builder: (_,state){
              return state is ExamSelected
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    child: Row(
                      children: [
                        Image.asset('${appAssets}man.png', width: 40, height: 40,),
                        const VerticalDivider(width: 5,),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Let's prepare for  ${state.course.name}  exam in ${state.course.lang}  language !",
                                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12,height: 1.6)).tr(),
                              ],
                            )
                        ),
                        const VerticalDivider(width: 5,),
                        BlocBuilder<ExamBloc, ExamState>(
                            buildWhen: (_,state)=> state is ExamUpdating || state is ExamUpdated,
                            builder: (_,state){
                              return ElevatedButton(
                                  onPressed: ()=>BlocProvider.of<ExamBloc>(context).add(SaveExamEvent(course: AuthViewModel.selectedCourse!)),
                                  child: state is ExamUpdating ? Utils.buttonProgressIndicator : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: const Text( 'Start').tr(),
                                  )
                              );
                            })
                      ],
                    ),
                  )
              : const SizedBox();
            }
        )
      ],
    );
  }
}

class ExamsListBuilder extends StatelessWidget {
  final bool isLoading;
  final List<Course>? courses;

  const ExamsListBuilder({
    Key? key,
    required this.isLoading,
    this.courses
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: isLoading ? 2 : courses!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 1.6),
        itemBuilder: (_,index){
          return isLoading
              ? const Loading(type: shimmer_2)
              : ExamItem(
              course: courses![index],
              onClick: (course){
                AuthViewModel.selectedCourse = course;
                BlocProvider.of<ExamBloc>(context).add(SelectCourseEvent(course: course));
              },
            );
        }
    );
  }
}


