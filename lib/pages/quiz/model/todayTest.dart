import 'package:equatable/equatable.dart';

class TodayTest extends Equatable{

  final String exam;
  final String date;
  final dynamic noOfQuestions;
  final String link;
  final String marks;

  const TodayTest({
    required this.exam,
    required this.date,
    required this.noOfQuestions,
    required this.link,
    required this.marks
  });

  static List<TodayTest> getTodayTestsList(List<dynamic> data){
    return data.map((e) => TodayTest.fromJson(e)).toList();
  }

  factory TodayTest.fromJson(Map<String,dynamic> data) {

    final exam = data['exam'];
    final date = data['date'];
    final noOfQuestions = data['noOfQuestions'];
    final link = data['link'];
    final marks = data['marks'];

    return TodayTest(
        exam: exam,
        date: date,
        noOfQuestions: noOfQuestions,
        link: link,
        marks: marks
    );
  }

  @override
  List<Object?> get props => [
    exam,
    date,
    noOfQuestions,
    link
  ];
}