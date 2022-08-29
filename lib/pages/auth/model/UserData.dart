
import 'package:equatable/equatable.dart';

class UserData extends Equatable{

  final String id;
  final String name;
  final String email;
  final String? exam;
  final String? gender;
  final String? city;
  final String? coins;
  final String? phone;
  final String? photo;
  final String joinedAt;
  final bool? isSubscribed;
  final String? subscriptionValidity;
  final String appLang;
  final String appTheme;

  const UserData({
    required this.id,
    required this.name,
    required this.exam,
    required this.email,
    required this.phone,
    required this.photo,
    this.gender,
    this.coins,
    this.city,
    this.isSubscribed = false,
    this.subscriptionValidity,
    required this.joinedAt,
    required this.appTheme,
    required this.appLang
  });

  static List<UserData> getUsersList(List<dynamic> data){
    return data.map((e) => UserData.fromJson(e)).toList();
  }

  factory UserData.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final email = data['email'];
    final exam = data['exam'];
    final phone = data['phone'];
    final photo = data['photo'];
    final coins = data['coins'];
    final joinedAt = data['joinedAt'];
    final appLang = data['appLang'];
    final appTheme = data['appTheme'];
    final gender = data['gender'];
    final city = data['city'];
    final isSubscribed = data['isSubscribed'];
    final subscriptionValidity = data['subscriptionValidity'];

    return UserData(
      id: id,
      name: name,
      email: email,
      exam: exam,
      photo: photo,
      phone: phone,
      appLang: appLang,
      appTheme: appTheme,
      joinedAt: joinedAt,
      coins: coins,
      gender: gender,
      city: city,
      isSubscribed: isSubscribed,
      subscriptionValidity: subscriptionValidity
    );
  }

  @override
  List<Object?> get props => [];
}