part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizMainExamsLoading extends QuizState {}

class QuizMainExamsFetched extends QuizState {
  final List<Exam> exams;
  QuizMainExamsFetched({required this.exams});
}

class QuizMainSubjectsLoading extends QuizState {}

class QuizMainSubjectsFetched extends QuizState {
  final List<Exam> exams;
  QuizMainSubjectsFetched({required this.exams});
}

class Checking extends QuizState {}

class Checked extends QuizState {
  final bool isValid;
  Checked({required this.isValid});
}

class TestListLoading extends QuizState {}

class TestListFetched extends QuizState {
  final List<Test> tests;
  TestListFetched({required this.tests});
}

class ChaptersLoading extends QuizState {}

class ChaptersFetched extends QuizState {
  final List<Chapter> chapter;
  ChaptersFetched({required this.chapter});
}


class QuestionIndex extends QuizState {
  final int index;
  QuestionIndex({required this.index});
}

class OptionSelected extends QuizState {
  final String option;

  OptionSelected({required this.option});
}

class QuestionsFetchLoading extends QuizState {}

class QuestionsFetched extends QuizState {
  final List<Question> questions;

  QuestionsFetched({required this.questions});
}

class QuizResultLoading extends QuizState {}

class QuizResult extends QuizState {

  final Result result;

  QuizResult({required this.result});
}