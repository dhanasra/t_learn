part of 'exam_bloc.dart';

@immutable
abstract class ExamState {}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamsFetched extends ExamState {
  final List<Course> courses;

  ExamsFetched({required this.courses});
}

class ExamSelected extends ExamState {
  final Course course;

  ExamSelected({required this.course});
}

class ExamUpdating extends ExamState {}

class ExamUpdated extends ExamState {}

class Exception extends ExamState {}
