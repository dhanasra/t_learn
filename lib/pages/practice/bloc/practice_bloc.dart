
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/practice/view_model/practice_view_model.dart';

import '../../../utils/fb.dart';
import '../../../utils/local_db.dart';
import '../../quiz/model/exam.dart';
import '../../quiz/model/question.dart';

part 'practice_event.dart';
part 'practice_state.dart';

class PracticeBloc extends Bloc<PracticeEvent, PracticeState> {
  PracticeBloc() : super(PracticeInitial()) {
    on<GetSubjects>(onGetSubjects);
    on<GetAllQuestions>(onGetQuestions);
  }

  void onGetSubjects(GetSubjects event, Emitter emit) async {
    emit(SubjectsLoading());

    final examCode = await LocalDB.getExamCode();
    final quizData = await DB.getOrderedData("${FirestorePath.practiceSubject}-$examCode", "id");

    emit(SubjectsFetched(exams: Exam.getExamsList(quizData)));
  }

  void onGetQuestions(GetAllQuestions questions, Emitter emit) async {
    emit(QuestionsLoading());
    var path = PracticeViewModel.selectedExam!.link;
    Response response = await Dio().get(path);
    var questions = Question.getQuestionList(response.data);
    emit(QuestionsFetched(questions: questions));
  }
}
