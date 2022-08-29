
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/analysis/model/analysis.dart';
import 'package:t_learn/pages/quiz/model/result.dart';

import '../../../utils/fb.dart';
import '../../../utils/local_db.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc() : super(AnalysisInitial()) {
    on<GetOverAllScores>(onGetAllScores);
    on<GetTestScores>(onGetAllTestScores);
  }

  void onGetAllScores(GetOverAllScores event, Emitter emit) async{

    emit(OverAllScoresLoading());

    String uid = Auth().firebaseAuth.currentUser!.uid;

    final overAllData =  await DB.getQuizAnalysisData();

    Analysis overAllAnalysis;
    try{
      overAllAnalysis = Analysis.fromJson(overAllData);
    }catch(e){
      overAllAnalysis = Analysis(
          id: uid,
          correct: "0",
          incorrect: "0",
          unattempted: "0",
          accuracy: "0",
          time: "0",
          percentage: "0"
      );
    }

    emit(OverAllScoresFetched(analysis: overAllAnalysis));
  }

  void onGetAllTestScores(GetTestScores event, Emitter emit) async{

    emit(TestScoresLoading());

    final examCode = await LocalDB.getExamCode();

    String uid = Auth().firebaseAuth.currentUser!.uid;

    final data  = await DB().fireStore.collection("${FirestorePath.quizAnalysis}-$examCode").doc(uid).get();
    List<Result> analysisData = [];

    try{
      analysisData = Result.getResultsList(data["analysis"]);
    }catch(e){
      analysisData = [];
    }

    emit(TestScoresFetched(result: analysisData));
  }
}
