part of 'practice_bloc.dart';

@immutable
abstract class PracticeState {}

class PracticeInitial extends PracticeState {}

class SubjectsFetched extends PracticeState {
  final List<Exam> exams;
  SubjectsFetched({required this.exams});
}

class SubjectsLoading extends PracticeState {}

class QuestionsLoading extends PracticeState {}

class QuestionsFetched extends PracticeState {
  final List<Question> questions;

  QuestionsFetched({required this.questions});
}
