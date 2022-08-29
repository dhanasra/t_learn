import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';
import 'package:t_learn/utils/globals.dart';

import '../../../../utils/fb.dart';
import '../../../../utils/local_db.dart';
import '../../../quiz/model/question.dart';

part 'kbc_event.dart';
part 'kbc_state.dart';

class KbcBloc extends Bloc<KbcEvent, KbcState> {

  KbcBloc() : super(KbcInitial()) {
    on<GetReady>(onGetReady);
    on<LeaveKbc>(onLeaveKBC);
    on<StopTimer>(onStopTimer);
  }

  void onStopTimer(StopTimer event, Emitter emit) async{
    emit(TimerStopped());
  }

  void onLeaveKBC(LeaveKbc event, Emitter emit) async{
    emit(KbcLeaving());
    print(Globals.coins);
    if(KBCViewModel.stage!=0){
      int amount = int.parse(KBCViewModel.amount);
      Globals.coins =
      "${int.parse(Globals.coins) + amount}";
      await DB.updateProfile({
        "coins": Globals.coins
      });
    }

    emit(KbcFinish());
  }

  void onGetReady(GetReady event, Emitter emit) async{
    emit(KbcLoading());

    final examCode = await LocalDB.getExamCode();
    List<Question> questions;
    if(KBCViewModel.questions.isEmpty) {
      await Future.delayed(const Duration(seconds: 5));
      dynamic questionsLink;
      await DB().fireStore.collection(FirestorePath.kbc)
          .doc(examCode).get().then((DocumentSnapshot doc) {
        var data = doc.data() as Map<String, dynamic>;
        questionsLink = data['link'];
      });
      Response response = await Dio().get(questionsLink);
      questions = Question.getQuestionList(response.data)..shuffle();
      KBCViewModel.questions = questions;
    }else{
      questions = KBCViewModel.questions..shuffle();
    }
    KBCViewModel.reset();
    emit(KbcReady(questions: questions));
  }
}
