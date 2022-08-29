import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/auth/view_models/auth_view_model.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/background.dart';
import '../../../widgets/toaster.dart';
import '../bloc/authentication_bloc.dart';


class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
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
        child: const Background(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: MainBody()
        )
    );
  }
}


class MainBody extends StatelessWidget {

  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final viewModel = AuthViewModel();

    return ListView(
      children: [

        const Text("Forgot Password ?", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30,)).tr(),

        Utils.dividerMedium,

        Row(children: [
          Text('explore_at', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Theme.of(context).canvasColor.withOpacity(0.6))).tr(),
          Utils.verticalDividerSmall,
          const Text('app_name', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.deepOrangeAccent)).tr()
        ]),

        Utils.divider_50,

        TextField(
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            controller: viewModel.emailController,
            decoration: const InputDecoration(labelText: 'Email Address')
        ),

        Utils.divider_50,

        BlocBuilder<AuthenticationBloc,AuthenticationState>(
            builder: (_,state){
              return ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : ()=> BlocProvider.of<AuthenticationBloc>(context).add(
                      ForgotPasswordEvent(email: viewModel.emailController.text)),
                  style: ElevatedButton.styleFrom( minimumSize: const Size(double.infinity, 50)),
                  child: state is! AuthLoading ? const Text( 'continue').tr() : Utils.buttonProgressIndicator
              );
            }),
      ],
    );
  }
}