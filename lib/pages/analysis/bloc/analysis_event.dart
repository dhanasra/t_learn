part of 'analysis_bloc.dart';

@immutable
abstract class AnalysisEvent {}

class GetOverAllScores extends AnalysisEvent {}

class GetTestScores extends AnalysisEvent {}