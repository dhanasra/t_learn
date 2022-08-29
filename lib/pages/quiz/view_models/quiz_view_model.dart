import 'package:t_learn/pages/quiz/model/question.dart';
import 'package:t_learn/utils/fb.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';
import '../model/chapter.dart';
import '../model/exam.dart';
import '../model/test.dart';

class QuizViewModel {

  static late QuizViewModel _instance;

  factory QuizViewModel() {
    _instance = QuizViewModel._internal();
    return _instance;
  }

  QuizViewModel._internal() {
    _init();
  }

  static Exam? selectedExam;
  static Test? selectedTest;

  static String type = "test";

  static Chapter? selectedChapter;

  static int timeTaken = 0;

  static List<Question> questions = [];
  static int currentQuestionIndex = 1;
  static Map<int, String> answers= {};

  _init(){

  }

  static openMail(){
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mailto,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Padi User Support'
      }),
    );
    launchUrl(emailLaunchUri);
  }
}