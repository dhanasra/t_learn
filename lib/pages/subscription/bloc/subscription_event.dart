part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionEvent {}

class GetAllSubscriptions extends SubscriptionEvent {}

class SubscriptionSuccess extends SubscriptionEvent {
  final Subscription subscription;
  SubscriptionSuccess({required this.subscription});
}

class SubscriptionFailure extends SubscriptionEvent {
  final Subscription subscription;
  SubscriptionFailure({required this.subscription});
}

class UseCoins extends SubscriptionEvent {
  final Subscription subscription;
  UseCoins({required this.subscription});
}