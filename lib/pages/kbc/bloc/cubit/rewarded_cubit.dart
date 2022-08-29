import 'package:flutter_bloc/flutter_bloc.dart';

class RewardedCubit extends Cubit<String> {
  RewardedCubit() : super("");

  void showRewardedAd()=>emit("showAd");

}
