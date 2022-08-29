part of 'practice_bloc.dart';

@immutable
abstract class PracticeEvent {}

class GetSubjects extends PracticeEvent {}

class GetAllQuestions extends PracticeEvent {}
