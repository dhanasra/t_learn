part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {}

class SavedInLocalDB extends AuthenticationState {}

class AuthFailure extends AuthenticationState {
  final String message;
  AuthFailure({required this.message});
}

