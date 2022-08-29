part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionDataFetched extends SubscriptionState {
  final List<Subscription> subscriptions;

  SubscriptionDataFetched({required this.subscriptions});
}

class PaymentSuccess extends SubscriptionState {
  final Subscription subscription;

  PaymentSuccess({required this.subscription});
}

class PaymentFailure extends SubscriptionState {
  final Subscription subscription;

  PaymentFailure({required this.subscription});
}

class PaymentLoading extends SubscriptionState {}

class NotEnoughCoins extends SubscriptionState {}

class CoinsLoading extends SubscriptionState {}