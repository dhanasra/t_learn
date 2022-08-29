

import 'package:t_learn/pages/quiz/model/question.dart';
import 'package:t_learn/utils/constants.dart';

class KBCViewModel {

  static late KBCViewModel _instance;

  factory KBCViewModel() {
    _instance = KBCViewModel._internal();
    return _instance;
  }

  KBCViewModel._internal() {
    _init();
  }

  static List<Question> questions = [];
  static Question cQuestion =  questions[0];
  static int questionsIndex = 0;
  static String amount = kbcCoins[0];
  static int stage = 0;
  static String selectedIndex = "";
  static bool isLifeLine3Enable = true;
  static bool isLifeLine2Enable = true;
  static bool isLifeLine1Enable = true;

  _init(){}

  static void reset(){
    questionsIndex = 0;
    cQuestion =  questions[0];
    stage = 0;
    amount = kbcCoins[0];
    selectedIndex = "";
    isLifeLine3Enable = true;
    isLifeLine2Enable = true;
    isLifeLine1Enable = true;
  }
}