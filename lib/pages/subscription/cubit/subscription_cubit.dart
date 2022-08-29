import 'package:bloc/bloc.dart';
class SubscriptionCubit extends Cubit<int> {
  SubscriptionCubit() : super(-1);

  void choosePackage(int index)=>emit(index);
}