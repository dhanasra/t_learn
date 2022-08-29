import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/splash/bloc/splash_bloc.dart';
import 'package:t_learn/utils/animation/scale_animation.dart';
import 'package:t_learn/widgets/background.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_)=>SplashBloc()..add(CheckAuth()),
      child: Background(
        child: Center(
            child: BlocListener<SplashBloc,SplashState>(
                listener: (_,state){
                  if(state is NoInternet){
                    const App().setNavigation(context, AppRoutes.noInternet);
                  } else if(state is Login){
                    const App().setNavigation(context, AppRoutes.landing);
                  }else{
                    const App().setNavigation(context, AppRoutes.setupLoading);
                  }
                },
                child: const SplashWidget()
            )
        ),
      )
    );
  }

}

