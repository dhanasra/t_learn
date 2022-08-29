import 'package:equatable/equatable.dart';

class Profile extends Equatable{

  final String name;
  final String? gender;
  final String phoneNumber;
  final String emailAddress;
  final String photoUrl;
  final String city;

  const Profile({
    required this.gender,
    required this.city,
    required this.emailAddress,
    required this.photoUrl,
    required this.phoneNumber,
    required this.name,
  });

  factory Profile.fromJson(Map<String,dynamic> data) {

    final gender = data['gender'];
    final city = data['city'];
    final emailAddress = data['emailAddress'];
    final photoUrl = data['photoUrl'];
    final phoneNumber = data['phoneNumber'];
    final name = data['name'];

    return Profile(
        gender: gender,
        city: city,
        emailAddress: emailAddress,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
        name: name
    );
  }

  @override
  List<Object?> get props => [
    gender,
    city,
    emailAddress,
    photoUrl,
    phoneNumber,
    name
  ];

}