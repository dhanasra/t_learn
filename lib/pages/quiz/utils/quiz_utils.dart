import 'package:t_learn/pages/quiz/model/result.dart';
import 'package:t_learn/utils/fb.dart';
import 'package:t_learn/utils/globals.dart';

import '../../../utils/date_utils.dart';
import '../../../utils/local_db.dart';
import '../../analysis/model/analysis.dart';

class QuizUtils {
  
  static Result getResult({required questions, required answers, required timeTaken, required name}){
    var correct = 0, incorrect = 0, unattempted = 0;

    for (var question in questions) {
      answers[question.id]!=null
          ? answers[question.id] == question.answer
          ? correct++ : incorrect++ : unattempted++;
    }

    double percentage = (correct/questions.length)*100;
    double accuracy = correct+incorrect==0 ? 0 : (correct/(correct+incorrect))*100;

    return Result(
        correct: correct,
        incorrect: incorrect,
        unattempted: unattempted,
        accuracy: accuracy.toStringAsFixed(2),
        timeTaken: timeTaken,
        percentage: percentage.toStringAsFixed(2),
        date: DateTime.now().millisecondsSinceEpoch,
        name: name
    );
  }

  static getLeaderBoard() async {
    final examCode = await LocalDB.getExamCode();

    final querySnapShotStream  = await DB().fireStore.collection(FirestorePath.quizToday)
        .doc(examCode).collection("${FirestorePath.quizResult}-${DateTimeUtils.getToday("dd-MMM-yyyy")}").get();
    return querySnapShotStream.docs.map((e) => e.data()).toList();
  }

  static addTodayTestData({required uid, required Result result}) async {
    final examCode = await LocalDB.getExamCode();

    var resultJson = {
      "uName": Globals.name,
      "uPhoto": Globals.photo,
      "uid": Auth().firebaseAuth.currentUser!.uid,
      "accuracy": result.accuracy,
      "score": result.correct
    };

    await DB().fireStore.collection(FirestorePath.quizToday)
        .doc(examCode).collection("${FirestorePath.quizResult}-${DateTimeUtils.getToday("dd-MMM-yyyy")}")
        .doc(uid).set(resultJson);
  }

  static addOverAllData({required uid, required Result result}) async {
    final examCode = await LocalDB.getExamCode();

    final data  = await DB().fireStore.collection("${FirestorePath.quizAnalysis}-$examCode").doc(uid).get();
    List<dynamic> analysisData = [];

    try{
      analysisData = data["analysis"];
    }catch(e){
      analysisData = [];
    }

    analysisData.add(Result.toJson(result));

    await DB.addUserQuizAnalysisData("${FirestorePath.quizAnalysis}-$examCode", {"analysis":analysisData});


    final overAllData =  await DB.getQuizAnalysisData();

    Analysis newAnalysis = QuizUtils.getOverAllAnalysis(
        uid: uid,
        overAllData: overAllData,
        result: result);

    await DB.addQuizAnalysisData(Analysis.toJson(newAnalysis));
  }

  static Analysis getOverAllAnalysis({required uid, required overAllData, required Result result}){

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

    var overAllCorrect = int.parse(overAllAnalysis.correct);
    var overAllIncorrect = int.parse(overAllAnalysis.incorrect);
    var overAllUnAttempted = int.parse(overAllAnalysis.unattempted);
    var overAllTime = double.parse(overAllAnalysis.time);
    var overAllAccuracy = double.parse(overAllAnalysis.accuracy);
    var overAllPercentage = double.parse(overAllAnalysis.percentage);

    Analysis newAnalysis = Analysis(
        id: uid,
        correct: "${overAllCorrect+result.correct}",
        incorrect: "${overAllIncorrect+result.incorrect}",
        unattempted: "${overAllUnAttempted+result.unattempted}",
        accuracy: "${(overAllAccuracy+num.parse(result.accuracy))/2}",
        time: "${(overAllTime+num.parse(result.timeTaken))/2}",
        percentage: "${(overAllPercentage+num.parse(result.percentage))/2}"
    );

    return newAnalysis;
  }


}