import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';

class OptionsCubit extends Cubit<String> {
  OptionsCubit() : super("Initial");

  void correct() => emit("correct");
  void wrong() => emit("wrong");
  void waiting() => emit("waiting");

  void lifeLine5050(){
    KBCViewModel.isLifeLine2Enable = false;
    if(KBCViewModel.cQuestion.answer.contains("A")
        || KBCViewModel.cQuestion.answer.contains("B")){
      emit("CD");
    }else{
      emit("AB");
    }
  }

}
