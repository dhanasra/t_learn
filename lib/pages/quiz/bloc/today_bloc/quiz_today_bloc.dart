
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/quiz/model/question.dart';
import 'package:t_learn/pages/quiz/model/result.dart';
import 'package:t_learn/pages/quiz/model/todayTest.dart';
import 'package:t_learn/pages/quiz/utils/quiz_utils.dart';

import '../../../../utils/date_utils.dart';
import '../../../../utils/fb.dart';
import '../../../../utils/local_db.dart';
import '../../view_models/quiz_view_model.dart';

part 'quiz_today_event.dart';
part 'quiz_today_state.dart';

class QuizTodayBloc extends Bloc<QuizTodayEvent, QuizTodayState> {
  QuizTodayBloc() : super(QuizTodayInitial()) {
    on<GetTodayQuizInfo>(getTodayQuizInfo);
    on<PrepareQuestions>(prepareQuestions);
    on<GetResult>(getResult);
  }

  void getResult(GetResult event, Emitter emit) async {
    emit(ResultLoading());
    emit(LeaderBoardLoading());
    var questions = QuizViewModel.questions;
    var answers = QuizViewModel.answers;
    String uid = Auth().firebaseAuth.currentUser!.uid;

    Result result =  QuizUtils.getResult(
        questions: questions, 
        answers: answers, 
        timeTaken: QuizViewModel.timeTaken.toString(), 
        name: "Daily Test"
    );
    await QuizUtils.addOverAllData(uid: uid, result: result);

    await QuizUtils.addTodayTestData(uid: uid, result: result);

    emit(ResultFetched(result: result));

    List toppers = await QuizUtils.getLeaderBoard();

    toppers.sort((a,b)=>b["score"].compareTo(a["score"]));

    var myRank = toppers.length.toString();
    var score = "0";
    for (var element in toppers) {
      if(element["uid"]==uid){
        myRank = (toppers.indexOf(element)+1).toString();
        score = element["score"].toString();
      }
    }


    await LocalDB.save(LocalDBKeys.today, DateTimeUtils.getToday("dd-MMM-yyyy"));

    emit(LeaderBoardFetched(toppers: toppers, myRank: myRank, score: score));
  }

  void prepareQuestions(PrepareQuestions event, Emitter emit) async{

    emit(PreparingQuestions());
    var path = event.test.link;
    Response response = await Dio().get(path);
    var questions = Question.getQuestionList(response.data);
    emit(QuestionsFetched(questions: questions));

  }

  void getTodayQuizInfo(GetTodayQuizInfo event, Emitter emit) async{
    final examCode = await LocalDB.getExamCode();

    try{

      Map<String, dynamic> quizTodayInfo = {};
      await DB().fireStore.collection(FirestorePath.quizToday).doc(examCode).get().then(
              (DocumentSnapshot doc) {
                quizTodayInfo = doc.data() as Map<String, dynamic>; }
      );

      emit(TodayQuizInfo(test: TodayTest.fromJson(quizTodayInfo)));

    }catch(e){
      return null;
    }
  }

}
