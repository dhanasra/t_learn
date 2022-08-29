part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class Login extends SplashState {}

class Home extends SplashState {}

class NoInternet extends SplashState {}