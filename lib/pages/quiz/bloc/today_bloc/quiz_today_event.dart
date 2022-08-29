part of 'quiz_today_bloc.dart';

@immutable
abstract class QuizTodayEvent {}

class GetTodayQuizInfo extends QuizTodayEvent {}

class PrepareQuestions extends QuizTodayEvent {
  final TodayTest test;

  PrepareQuestions({required this.test});
}

class GetResult extends QuizTodayEvent {}