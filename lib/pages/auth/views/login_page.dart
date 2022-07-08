import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/pages/auth/view_models/auth_view_model.dart';
import 'package:t_learn/widgets/toaster.dart';

import '../../../app/app_routes.dart';
import '../../../layout/utils/responsive_layout_builder.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/carousel_view.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=>AuthenticationBloc(),
    child:Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                  listenWhen: (_,state) {
                    return state is AuthSuccess || state is AuthFailure;
                  },
                  listener: (context, state) {
                    if(state is AuthSuccess) const App().setNavigation(context, AppRoutes.chat);
                    if(state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(Toaster.snack(content: state.message));
                      AuthViewModel().clearInputs();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: ResponsiveLayoutBuilder(
                      large: LoginPageLarge(),
                      small: MainBody(isLarge: false),
                    )
              )),
        )
    ));
  }
}

class LoginPageLarge extends StatelessWidget {
  const LoginPageLarge({Key? key}) : super(key: key);

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

    final showPassword = ValueNotifier<bool>(false);
    final viewModel = AuthViewModel();

    return Column(
      crossAxisAlignment: isLarge ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      children: [
        Text(
          "Login",
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
              'Hi, Welcome back to ',
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
                const SizedBox(height: 20,),
                ValueListenableBuilder(
                    valueListenable: showPassword,
                    builder: (_, isPressed, child){
                      return TextField(
                        autofocus: false,
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                        controller: viewModel.passwordController,
                        obscureText: showPassword.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              icon: Icon(
                                  showPassword.value
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined ),
                              splashRadius: 18,
                              onPressed: (){
                                showPassword.value = !showPassword.value;
                              }
                          ),
                        ),
                      );
                    }),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: ()=>const App().setNavigation(context, AppRoutes.forgotPassword),
                      child: const Text('Forgot password ?',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),)),
                ),
                const Divider(height: 50,color: Colors.transparent,),
                BlocBuilder<AuthenticationBloc,AuthenticationState>(
                  builder: (_,state){
                    return ElevatedButton(
                        onPressed: state is AuthLoading
                            ? null
                            : (){ BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LoginEvent(
                                    email: viewModel.emailController.text,
                                    password: viewModel.passwordController.text));},
                        style: ElevatedButton.styleFrom( minimumSize: Size(double.infinity, isLarge ? 60 : 50), ),
                        child: (state is! AuthLoading)
                            ? Text( 'Login', style: TextStyle( fontSize: isLarge ? 16 : 14 ),)
                            : const SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),)
                    );
                }),
                const Divider(height: 20,color: Colors.transparent,),
                Wrap(
                  children: [
                    Text("Don't have an account?",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),),
                    const SizedBox(width: 10,),
                    InkWell(
                      child: const Text('Signup',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),),
                      onTap: ()=>const App().setNavigation(context, AppRoutes.signup),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}