import 'package:t_learn/pages/quiz/model/question.dart';

import '../../quiz/model/exam.dart';

class PracticeViewModel {

  static late PracticeViewModel _instance;

  factory PracticeViewModel() {
    _instance = PracticeViewModel._internal();
    return _instance;
  }

  PracticeViewModel._internal();

  static Exam? selectedExam;

  String getAnswer(Question question){
    if(question.answer.toUpperCase()=="A"){
      return question.option1;
    }else if(question.answer.toUpperCase()=="B"){
      return question.option2;
    }else if(question.answer.toUpperCase()=="C"){
      return question.option3;
    }else if(question.answer.toUpperCase()=="D"){
      return question.option4;
    }else {
      return question.option1;
    }
  }

}