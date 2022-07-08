import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/auth/view_models/auth_view_model.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../layout/utils/responsive_layout_builder.dart';
import '../../../widgets/toaster.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/carousel_view.dart';


class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child:BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (_,state) {
                return state is AuthSuccess || state is AuthFailure;
              },
              listener: (context, state) {
                if(state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      Toaster.snack(content: "Password reset link has been sent to your email. Check your email"));
                  const App().setNavigation(context, AppRoutes.login);
                }
                if(state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(Toaster.snack(content: state.message));
                  AuthViewModel().clearInputs();
                }
              },
              child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: ResponsiveLayoutBuilder(
                    large: ForgotPasswordPageLarge(),
                    small: MainBody(isLarge: false),
                  )
              )))
    );
  }
}

class ForgotPasswordPageLarge extends StatelessWidget {
  const ForgotPasswordPageLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: CarouselView()
        ),
        Expanded(
            child: Column(
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
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child:  MainBody( isLarge: true,),
                      ),
                    )
                  ],
                ),
                const Spacer()
              ],
            )
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

    final viewModel = AuthViewModel();

    return Column(
      crossAxisAlignment: isLarge ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      children: [
        Text(
          "Forgot Password ?",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: isLarge ? 20 : 30,
              color: Colors.black.withOpacity(0.7)
          ),
        ),
        const Divider(color:Colors.transparent,height: 10,),
        Row(
          mainAxisAlignment: isLarge ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              'Explore the best learning at ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isLarge ? 12 : 14,
                  color: Colors.grey.withOpacity(0.8)
              ),
            ),
            const SizedBox(width: 5,),
            const Text(
              'TL',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.deepOrangeAccent
              ),
            ),
          ],
        ),
        const Divider(color:Colors.transparent,height: 40,),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                TextField(
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                  controller: viewModel.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                ),
                const Divider(height: 50,color: Colors.transparent,),
                BlocBuilder<AuthenticationBloc,AuthenticationState>(
                    builder: (_,state){
                      return ElevatedButton(
                          onPressed: state is AuthLoading
                              ? null
                              : (){ BlocProvider.of<AuthenticationBloc>(context).add(ForgotPasswordEvent(email: viewModel.emailController.text));},
                          style: ElevatedButton.styleFrom( minimumSize: Size(double.infinity, isLarge ? 60 : 50), ),
                          child: (state is! AuthLoading)
                              ? Text( 'Continue', style: TextStyle( fontSize: isLarge ? 16 : 14 ),)
                              : const SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),)
                      );
                    }),
                const Divider(height: 20,color: Colors.transparent,),
              ],
            ),
          ),
        )
      ],
    );
  }
}