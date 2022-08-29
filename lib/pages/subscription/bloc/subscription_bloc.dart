
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:t_learn/pages/auth/model/UserData.dart';
import 'package:t_learn/pages/subscription/model/Subscription.dart';
import 'package:t_learn/utils/date_utils.dart';
import 'package:t_learn/utils/globals.dart';

import '../../../utils/fb.dart';
import '../../../utils/local_db.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionInitial()) {
    on<GetAllSubscriptions>(onGetSubscription);
    on<SubscriptionSuccess>(onSubscriptionSuccess);
    on<SubscriptionFailure>(onSubscriptionFailure);
    on<UseCoins>(onUseCoins);
  }

  void onUseCoins(UseCoins event, Emitter emit) async{

    emit(CoinsLoading());

    int coins = int.parse(event.subscription.coins);
    int myCoins = int.parse(Globals.coins);

    if(myCoins>coins){
      await DB.updateProfile({
        "isSubscribed": true,
        "coins": "${myCoins-coins}",
        "subscriptionValidity": event.subscription.validityInMilliseconds
      });
      emit(PaymentSuccess(subscription: event.subscription));
    }else{
      emit(NotEnoughCoins());
    }
  }

  void onSubscriptionSuccess(SubscriptionSuccess event, Emitter emit) async{

    await DB.updateProfile({
      "isSubscribed": true,
      "subscriptionValidity": event.subscription.validityInMilliseconds
    });

    emit(PaymentSuccess(subscription: event.subscription));
  }

  void onSubscriptionFailure(SubscriptionFailure event, Emitter emit) async{
    emit(PaymentFailure(subscription: event.subscription));
  }

  void onGetSubscription(GetAllSubscriptions event, Emitter emit) async{
    emit(SubscriptionLoading());

    final examCode = await LocalDB.getExamCode();
    final data = await DB.getOrderedData("${FirestorePath.subscription}-$examCode", "id");
    emit(SubscriptionDataFetched(subscriptions: Subscription.getSubscriptionList(data)));
  }

}
