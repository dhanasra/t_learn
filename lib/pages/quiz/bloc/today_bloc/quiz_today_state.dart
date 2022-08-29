part of 'quiz_today_bloc.dart';

@immutable
abstract class QuizTodayState {}

class QuizTodayInitial extends QuizTodayState {}

class TodayQuizInfo extends QuizTodayState {
  final TodayTest test;

  TodayQuizInfo({required this.test});
}

class PreparingQuestions extends QuizTodayState {}

class QuestionsFetched extends QuizTodayState {
  final List<Question> questions;

  QuestionsFetched({required this.questions});
}

class ResultFetched extends QuizTodayState {
  final Result result;

  ResultFetched ({required this.result});
}

class ResultLoading extends QuizTodayState {}

class LeaderBoardLoading extends QuizTodayState {}


class LeaderBoardFetched extends QuizTodayState {
  final List toppers;
  final String myRank;
  final String score;

  LeaderBoardFetched({required this.toppers, required this.myRank, required this.score});
}