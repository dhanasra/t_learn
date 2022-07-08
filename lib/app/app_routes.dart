import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/account/bloc/profile_bloc.dart';
import 'package:t_learn/pages/account/views/app_settings.dart';
import 'package:t_learn/pages/account/views/edit_profile.dart';
import 'package:t_learn/pages/account/views/exam_settings.dart';
import 'package:t_learn/pages/account/views/my_profile.dart';
import 'package:t_learn/pages/auth/views/details_page.dart';
import 'package:t_learn/pages/auth/views/forgot_password_page.dart';
import 'package:t_learn/pages/auth/views/login_page.dart';
import 'package:t_learn/pages/auth/views/setup_loading_page.dart';
import 'package:t_learn/pages/auth/views/signup_page.dart';
import 'package:t_learn/pages/chat/bloc/chat_bloc.dart';
import 'package:t_learn/pages/chat/views/chat_page.dart';

import '../pages/auth/bloc/authentication_bloc.dart';

class AppRoutes {

  //authentication
  static const String signup = 'auth/signup';
  static const String login = 'auth/login';
  static const String name = 'auth/name';
  static const String forgotPassword = 'auth/forgot_password';
  static const String setupLoading = 'auth/setup_loading';

  //profile
  static const String appSettings = 'account/app_settings';
  static const String examSettings = 'account/exam_settings';
  static const String editProfile = 'account/profile/edit_profile';
  static const String myProfile = 'account/profile';

  //chat
  static const String chat = 'chat';

  Route getRoutes(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case chat: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const ChatPage() );
      case appSettings: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const AppSettings() );
      case examSettings: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const ExamSettings() );
      case editProfile: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const EditProfile() );
      case myProfile: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const MyProfile() );
      case setupLoading: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const SetupLoadingPage() );
      case name: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const DetailsPage() );
      case forgotPassword: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const ForgotPasswordPage() );
      case login: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const LoginPage() );
      case signup: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const SignupPage() );
      default: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => Container() );
    }
  }

  getWidget(BuildContext context, String appRouteName){
    switch(appRouteName) {
      case chat: return BlocProvider( create: (_)=> ChatBloc()..add(RequestMessageEvent()), child: const ChatPage() );
      case appSettings: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const AppSettings() );
      case examSettings: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const ExamSettings() );
      case myProfile: return BlocProvider( create: (_)=> ProfileBloc(), child: const MyProfile() );
      case editProfile: return BlocProvider( create: (_)=> ProfileBloc(), child: const EditProfile() );
      case setupLoading: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const SetupLoadingPage() );
      case name: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const DetailsPage() );
      case forgotPassword: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const ForgotPasswordPage() );
      case login: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const LoginPage() );
      case signup: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const SignupPage() );
      default: return Container();
    }
  }

}