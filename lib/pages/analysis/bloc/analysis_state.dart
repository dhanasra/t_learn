part of 'analysis_bloc.dart';

@immutable
abstract class AnalysisState {}

class AnalysisInitial extends AnalysisState {}

class OverAllScoresLoading extends AnalysisState {}

class OverAllScoresFetched extends AnalysisState {
  final Analysis analysis;

  OverAllScoresFetched({required this.analysis});
}

class TestScoresLoading extends AnalysisState {}

class TestScoresFetched extends AnalysisState {
  final List<Result> result;

  TestScoresFetched({required this.result});
}