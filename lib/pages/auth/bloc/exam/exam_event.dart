part of 'exam_bloc.dart';

@immutable
abstract class ExamEvent {}

class GetAllExams extends ExamEvent {}

class SelectCourseEvent extends ExamEvent{
  final Course course;

  SelectCourseEvent({
    required this.course
  });
}

class SaveExamEvent extends ExamEvent {
  final Course course;

  SaveExamEvent({
    required this.course
  });
}