part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class SwitchQuestionEvent extends QuizEvent {
  final int index;

  SwitchQuestionEvent({required this.index});
}

class OptionSelectEvent extends QuizEvent {
  final int questionIndex;
  final String option;

  OptionSelectEvent({
    required this.option,
    required this.questionIndex
  });
}

class CheckTodayTest extends QuizEvent {}

class GetQuestionEvent extends QuizEvent {}

class GetMainExamsEvent extends QuizEvent {}

class GetMainSubjectsEvent extends QuizEvent {}

class GetTestListEvent extends QuizEvent {}

class GetChaptersEvent extends QuizEvent {}

class GetQuizResultEvent extends QuizEvent {}