import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/utils/date_utils.dart';

class Subscription extends Equatable{

  final int id;
  final String name;
  final String oldPrice;
  final String price;
  final String period;
  final String coins;
  final String validity;
  final String validityInMilliseconds;

  const Subscription({
    required this.id,
    required this.name,
    required this.oldPrice,
    required this.price,
    required this.period,
    required this.coins,
    required this.validity,
    required this.validityInMilliseconds
  });

  static List<Subscription> getSubscriptionList(List<dynamic> data){
    return data.map((e) => Subscription.fromJson(e)).toList();
  }

  factory Subscription.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final oldPrice = data['oldPrice'];
    final price = data['price'];
    final coins = data['coins'];
    final period =  DateTimeUtils.getDateFromMonths(data['period']);
    final validity = DateTimeUtils.getValidity(data['period']);
    final validityInMilliseconds = DateTimeUtils.getValidityInMilliseconds(data['period']);


    return Subscription(
        id: id,
        name: name,
        oldPrice: oldPrice,
        price: price,
        coins: coins,
        period: period,
        validity: validity,
        validityInMilliseconds: validityInMilliseconds
    );
  }

  @override
  List<Object?> get props => [];
}