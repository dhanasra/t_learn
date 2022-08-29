part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}


class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class Updating extends ProfileState {}

class ProfileFetched extends ProfileState {
  final UserData userData;
  ProfileFetched({required this.userData});
}

class EditProfileSuccess extends ProfileState {}