import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/utils/fb.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashBloc() : super(SplashInitial()) {
    on<CheckAuth>(_onCheckAuth);
  }

  void _onCheckAuth(CheckAuth event, Emitter emit)async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(NoInternet());
    } else {
      User? user = Auth().firebaseAuth.currentUser;
      await Future.delayed(const Duration(seconds: 3), () {
        emit(user != null ? Home() : Login());
      });
    }
  }

}
