import 'package:equatable/equatable.dart';

class Analysis extends Equatable{

  final String id;
  final String correct;
  final String incorrect;
  final String unattempted;
  final String accuracy;
  final String percentage;
  final String time;

  const Analysis({
    required this.id,
    required this.correct,
    required this.incorrect,
    required this.unattempted,
    required this.accuracy,
    required this.time,
    required this.percentage
  });

  static List<Analysis> getAnalysissList(List<dynamic> data){
    return data.map((e) => Analysis.fromJson(e)).toList();
  }

  static toJson(Analysis analysis){
    return {
      "id": analysis.id,
      "correct": analysis.correct,
      "incorrect": analysis.incorrect,
      "unattempted": analysis.unattempted,
      "accuracy": analysis.accuracy,
      "time": analysis.time,
      "percentage": analysis.percentage
    };
  }

  factory Analysis.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final correct = data['correct'];
    final incorrect = data['incorrect'];
    final unattempted = data['unattempted'];
    final accuracy = data['accuracy'];
    final time = data['time'];
    final percentage = data['percentage'];

    return Analysis(
      id: id,
      correct: correct,
      incorrect: incorrect,
      unattempted: unattempted,
      accuracy: accuracy,
      time: time,
      percentage: percentage
    );
  }

  @override
  List<Object?> get props => [
    id,
    correct,
    incorrect,
    unattempted,
    accuracy
  ];
}