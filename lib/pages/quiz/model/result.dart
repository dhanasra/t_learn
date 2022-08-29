import 'package:equatable/equatable.dart';

class Result extends Equatable{

  final int date;
  final String name;
  final int correct;
  final int incorrect;
  final int unattempted;
  final String accuracy;
  final String percentage;
  final String timeTaken;

  const Result({
    required this.correct,
    required this.incorrect,
    required this.unattempted,
    required this.accuracy,
    required this.timeTaken,
    required this.percentage,
    required this.name,
    required this.date
  });

  static List<Result> getResultsList(List<dynamic> data){
    return data.map((e) => Result.fromJson(e)).toList();
  }

  static toJson(Result result) {
    return {
      "correct": result.correct,
      "incorrect": result.incorrect,
      "unattempted": result.unattempted,
      "timeTaken": result.timeTaken,
      "percentage": result.percentage,
      "accuracy": result.accuracy,
      "name": result.name,
      "date": result.date
    };
  }

  factory Result.fromJson(Map<String,dynamic> data) {

    final correct = data['correct'];
    final incorrect = data['incorrect'];
    final unattempted = data['unattempted'];
    final timeTaken = data['timeTaken'];
    final percentage = data['percentage'];
    final accuracy = data['accuracy'];
    final date = data['date'];
    final name = data['name'];

    return Result(
      correct: correct,
      incorrect: incorrect,
      unattempted: unattempted,
      timeTaken: timeTaken,
      percentage: percentage,
      accuracy: accuracy,
      name: name,
      date: date
    );
  }

  @override
  List<Object?> get props => [
    correct,
    incorrect,
    unattempted,
    timeTaken,
    percentage
  ];
}