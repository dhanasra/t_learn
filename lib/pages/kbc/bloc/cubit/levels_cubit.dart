import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/fb.dart';
import '../../../../utils/globals.dart';

class LevelsCubit extends Cubit<String> {
  LevelsCubit() : super("${KBCViewModel.stage}");

  void moveNext() async {
    await Future.delayed(const Duration(milliseconds: 1000),(){
      KBCViewModel.cQuestion = KBCViewModel.questions[++KBCViewModel.stage];
      if(KBCViewModel.stage<15) {
        KBCViewModel.amount = kbcCoins[KBCViewModel.stage];
      }
      emit("${KBCViewModel.stage}");
    });
    await Future.delayed(const Duration(milliseconds: 1000),() async {
      if(KBCViewModel.stage==15){
        int amount = int.parse(KBCViewModel.amount);
        Globals.coins = "${int.parse(Globals.coins) + amount}";
        await DB.updateProfile({
          "coins": Globals.coins
        });
        emit("goBackHome");
      }else {
        emit("goBack");
      }
    });
  }

}
