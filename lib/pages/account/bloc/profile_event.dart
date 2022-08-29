part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final String name;
  final String? phoneNumber;
  final String? photoUrl;
  final String? city;
  final String gender;

  EditProfileEvent({
    required this.phoneNumber,
    required this.photoUrl,
    required this.gender,
    required this.city,
    required this.name
  });
}