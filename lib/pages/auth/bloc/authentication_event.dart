part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class GoogleAuthEvent extends AuthenticationEvent{}

class UserDetailsEvent extends AuthenticationEvent{
  final String name;

  UserDetailsEvent({
    required this.name
  });

}

class ForgotPasswordEvent extends AuthenticationEvent{
  final String email;

  ForgotPasswordEvent({
    required this.email
  });

}

class LoginEvent extends AuthenticationEvent{
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password
  });

}

class SignupEvent extends AuthenticationEvent{
  final String email;
  final String password;

  SignupEvent({
    required this.email,
    required this.password
  });
}

class SaveInLocalDB extends AuthenticationEvent{}