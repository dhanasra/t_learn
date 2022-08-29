
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:t_learn/pages/analysis/model/analysis.dart';
import 'package:t_learn/pages/quiz/model/chapter.dart';
import 'package:t_learn/pages/quiz/model/exam.dart';
import 'package:t_learn/pages/quiz/model/question.dart';
import 'package:t_learn/pages/quiz/model/result.dart';
import 'package:t_learn/pages/quiz/model/test.dart';
import 'package:t_learn/pages/quiz/utils/quiz_utils.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';

import '../../../../utils/date_utils.dart';
import '../../../../utils/fb.dart';
import '../../../../utils/local_db.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  QuizBloc() : super(QuizInitial()) {
    on<SwitchQuestionEvent>(onSwitchQuestion);
    on<OptionSelectEvent>(onSelectOption);
    on<GetQuestionEvent>(onGetQuestions);
    on<GetMainExamsEvent>(onGetMainExams);
    on<GetMainSubjectsEvent>(onGetMainSubjects);
    on<GetTestListEvent>(onGetTestList);
    on<GetQuizResultEvent>(onGetQuizResult);
    on<GetChaptersEvent>(onGetChaptersList);
    on<CheckTodayTest>(onCheckTodayTest);
  }

  void onCheckTodayTest(CheckTodayTest event, Emitter emit) async {
    emit(Checking());

    String? testDate = await LocalDB.get(String, LocalDBKeys.today);
    emit(Checked(isValid: testDate==null || testDate=="" || testDate!=DateTimeUtils.getToday("dd-MMM-yyyy")));
  }

  void onGetQuestions(GetQuestionEvent event, Emitter emit) async {
    emit(QuestionsFetchLoading());
    var path = QuizViewModel.selectedTest!.link;
    Response response = await Dio().get(path);
    var questions = Question.getQuestionList(response.data);
    emit(QuestionsFetched(questions: questions));
  }

  void onSwitchQuestion(SwitchQuestionEvent event, Emitter emit){
    emit(QuestionIndex(index: event.index));
  }

  void onSelectOption(OptionSelectEvent event, Emitter emit){
    QuizViewModel.answers[QuizViewModel.currentQuestionIndex] = event.option;
    emit(OptionSelected(option: event.option));
  }

  void onGetMainExams(GetMainExamsEvent event, Emitter emit) async {
    emit(QuizMainExamsLoading());

    final examCode = await LocalDB.getExamCode();
    final quizData = await DB.getOrderedData("${FirestorePath.quizExam}-$examCode", "id");

    emit(QuizMainExamsFetched(exams: Exam.getExamsList(quizData)));
  }

  void onGetMainSubjects(GetMainSubjectsEvent event, Emitter emit) async {
    emit(QuizMainSubjectsLoading());

    final examCode = await LocalDB.getExamCode();
    final quizData = await DB.getOrderedData("${FirestorePath.quizSubject}-$examCode", "id");
    emit(QuizMainSubjectsFetched(exams: Exam.getExamsList(quizData)));
  }

  void onGetTestList(GetTestListEvent event, Emitter emit) async {
    emit(TestListLoading());
    var path = QuizViewModel.selectedChapter!.link;
    Response response = await Dio().get(path);
    var testListData = Test.getTestsList(response.data);
    emit(TestListFetched(tests: testListData));
  }

  void onGetChaptersList(GetChaptersEvent event, Emitter emit) async {
    emit(ChaptersLoading());
    var path = QuizViewModel.selectedExam!.link;
    Response response = await Dio().get(path);
    var chaptersData = Chapter.getChaptersList(response.data);
    emit(ChaptersFetched(chapter: chaptersData));
  }

  void onGetQuizResult(GetQuizResultEvent event, Emitter emit) async {
    emit(QuizResultLoading());

    var questions = QuizViewModel.questions;
    var answers = QuizViewModel.answers;
    String uid = Auth().firebaseAuth.currentUser!.uid;

    Result result =  QuizUtils.getResult(
        questions: questions,
        answers: answers,
        timeTaken: QuizViewModel.timeTaken.toString(),
        name: QuizViewModel.selectedTest!.name
    );

    await QuizUtils.addOverAllData(uid: uid, result: result);

    emit(QuizResult(result: result));
  }
}
