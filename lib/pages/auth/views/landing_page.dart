import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/layout/utils/responsive_layout_builder.dart';
import 'package:t_learn/pages/auth/bloc/authentication_bloc.dart';
import 'package:t_learn/pages/auth/widgets/carousel_view.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';

class LandingPage extends StatelessWidget {

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (_)=>AuthenticationBloc(),
          child: const Scaffold(
          backgroundColor: Colors.white,
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
                    child: ResponsiveLayoutBuilder(
                      small: LandingPageSmall(),
                      large: LandingPageLarge(),
                    )
                )
            ),
        )
    );
  }
}

class LandingPageLarge extends StatelessWidget {
  const LandingPageLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: CarouselView()
        ),
        Expanded(
            child: MainBody( isLarge: true,)
        )
      ],
    );
  }
}

class LandingPageSmall extends StatelessWidget {
  const LandingPageSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: const [
            Expanded(
              flex: 7, child: CarouselView()
            ),
            Expanded(
              flex: 3, child: MainBody( isLarge: false,)
            )
          ],
        );
  }
}



class MainBody extends StatelessWidget {
  final bool isLarge;

  const MainBody({Key? key, required this.isLarge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(isLarge) const WebHeaderWidget(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(isLarge ? 400: 300, isLarge ? 70 : 50),
                ).copyWith(backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
                onPressed: (){
                  BlocProvider.of<AuthenticationBloc>(context).add(GoogleAuthEvent());
                },
                child: FittedBox(
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.google),
                      const SizedBox(width: 10,),
                      Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: isLarge ? 18 : 14
                          ),
                      )
                    ],
                  )
              )
            ),
            const Divider(color: Colors.transparent,),
            TextButton(onPressed: ()=>const App().setNavigation(context, AppRoutes.signup),
                child: const Text('Signup with Email',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),)),
            const Divider(color: Colors.transparent,),
            Wrap(
              children: [
                Text('Already have an account?',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                const SizedBox(width: 10,),
                InkWell(
                  child: const Text('Sign In',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                  onTap: ()=>const App().setNavigation(context, AppRoutes.login),
                )
              ],
            )
          ]
    );
  }
}

class WebHeaderWidget extends StatelessWidget {
  const WebHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_logo.png', height: 50,),
            const Text(
              'The learning academy',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Colors.deepOrangeAccent
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Text(
          'Empower yourself with Education',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.black.withOpacity(0.5)
          ),
        ),
        const SizedBox(height: 100,)
      ],
    );
  }
}

