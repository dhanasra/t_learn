import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/auth/model/course.dart';
import 'package:t_learn/utils/fb.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  ExamBloc() : super(ExamInitial()) {
    on<GetAllExams>(onGetAllExams);
    on<SaveExamEvent>(onSaveExam);
    on<SelectCourseEvent>(onSelectedExam);
  }

  void onSelectedExam(SelectCourseEvent event, Emitter emit) async{
    emit(ExamSelected(course: event.course));
  }

  void onGetAllExams(GetAllExams event, Emitter emit) async{
    emit(ExamLoading());
    try{
      var data = await DB.getOrderedData(FirestorePath.exams, "id");
      emit(ExamsFetched(courses: Course.getCourseList(data)));
    }catch(e){
      emit(Exception());
    }
  }

  void onSaveExam(SaveExamEvent event, Emitter emit) async{
    emit(ExamUpdating());
    try{
      await DB.updateProfile({"exam":event.course.code});
      emit(ExamUpdated());
    }catch(e){
      emit(Exception());
    }
  }
}
