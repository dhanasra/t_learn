import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/auth/bloc/authentication_bloc.dart';
import 'package:t_learn/pages/auth/widgets/carousel_view.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';

class LandingPage extends StatelessWidget {

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: MainBody(),
    );
  }
}



class MainBody extends StatelessWidget {

  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: CarouselView()),

            ElevatedButton(
                onPressed: ()=>BlocProvider.of<AuthenticationBloc>(context).add(GoogleAuthEvent()),
                style: ElevatedButton.styleFrom(minimumSize: const Size(300,50)),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(FontAwesomeIcons.google),
                      Utils.verticalDividerMedium,
                      const Text('continue_with_google').tr()
                    ],
              )
            ),

            Utils.divider,

            TextButton(
                onPressed: ()=>const App().setNavigation(context, AppRoutes.signup),
                child: const Text('signup_with_email').tr()
            ),

            Utils.divider,

            Wrap(
              children: [
                const Text('already_have_an_account?', style: TextStyle(fontWeight: FontWeight.w500)).tr(),
                Utils.verticalDividerSmall,
                InkWell(
                  onTap: ()=>const App().setNavigation(context, AppRoutes.login),
                  child: Text('sign_in', style: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w500)).tr()
                )
              ],
            )
          ]
    );
  }
}



