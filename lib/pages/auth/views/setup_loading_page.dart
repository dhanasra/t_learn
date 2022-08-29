import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/account/bloc/theme/theme_bloc.dart';
import 'package:t_learn/pages/auth/bloc/authentication_bloc.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';

class SetupLoadingPage extends StatelessWidget {
  const SetupLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc,  AuthenticationState>(
        listener: (_,state){
          if(state is SavedInLocalDB){
            context.setLocale((Locale(Globals.language.split("_")[0])));
            BlocProvider.of<ThemeBloc>(context).add(UpdateTheme(theme: Globals.theme));
            const App().setNavigation(context, AppRoutes.home);
          }
        },
        child: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('${appAssets}setup_loading.gif', width: 100,),
                Utils.divider,
                const Text("set_up_account", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)).tr()
              ],
            )
        ),
    );
  }
}
