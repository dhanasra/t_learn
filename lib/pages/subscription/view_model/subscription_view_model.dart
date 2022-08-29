import 'package:t_learn/pages/subscription/model/Subscription.dart';

class SubscriptionViewModel {

  static late SubscriptionViewModel _instance;
  factory SubscriptionViewModel() {
    _instance = SubscriptionViewModel._internal();
    return _instance;
  }
  SubscriptionViewModel._internal();

  static List<Subscription> subscriptions = [];
  static Subscription? selectedPackage;

}