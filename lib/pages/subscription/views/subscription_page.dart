import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/subscription/bloc/subscription_bloc.dart';
import 'package:t_learn/pages/subscription/cubit/subscription_cubit.dart';
import 'package:t_learn/pages/subscription/model/Subscription.dart';
import 'package:t_learn/pages/subscription/view_model/subscription_view_model.dart';
import 'package:t_learn/pages/subscription/widgets/payment_failure_bottom_sheet.dart';
import 'package:t_learn/pages/subscription/widgets/price_item.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/toaster.dart';

import '../../../utils/globals.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/constants.dart';
import '../../../widgets/loading.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Background(
        isBackPressed: true,
        title: "Upgrade",
        child: BlocListener<SubscriptionBloc, SubscriptionState>(
          listenWhen: (_, state) =>
          state is PaymentSuccess || state is PaymentFailure || state is NotEnoughCoins,
          listener: (context, state) {
            if (state is PaymentSuccess) {
              const App().setNavigation(context, AppRoutes.subscriptionSuccess);
            } else if (state is PaymentFailure) {
              showBottomSheet(context);
            } else if (state is NotEnoughCoins) {
              ScaffoldMessenger.of(context).showSnackBar(
                  Toaster.snack(content: "Not enough coins. You have only ${Globals.coins} coins!!!")
              );
            }
          },
          child: const MainBody(),
        )
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
            top: Radius.circular(25)),),
        backgroundColor: Theme.of(context).cardColor, context: context,
        builder: (BuildContext context) {
          return const PaymentFailureBottomSheet();
        });
  }


}

class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}



class _MainBodyState extends State<MainBody> {

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Text(Globals.exam, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColorLight),).tr(),
                Text("Unlock all tests & materials", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Theme.of(context).canvasColor),).tr(),

                Utils.dividerLarge,

                BlocBuilder<SubscriptionBloc,SubscriptionState>(
                    buildWhen: (_,state)=> state is SubscriptionDataFetched || state is SubscriptionLoading,
                    builder: (_,state){
                      if(state is SubscriptionLoading){
                        return const SubscriptionListBuilder(isLoading: true,);
                      }else if(state is SubscriptionDataFetched){
                        SubscriptionViewModel.subscriptions = state.subscriptions;
                        SubscriptionViewModel.selectedPackage = state.subscriptions[0];
                        BlocProvider.of<SubscriptionCubit>(context).choosePackage(0);
                        return SubscriptionListBuilder(isLoading: false, subscriptions: state.subscriptions,);
                      }else{
                        return const SizedBox();
                      }
                    }),

                Utils.dividerLarge,

                BlocBuilder<SubscriptionCubit, int>(
                    builder: (_,state){
                      return state==-1
                          ? const SizedBox()
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: ()=>BlocProvider.of<SubscriptionBloc>(context).add(
                                    UseCoins(subscription: SubscriptionViewModel.subscriptions[1])),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    child: Text( 'Use ${
                                        int.parse(SubscriptionViewModel.subscriptions[state].coins)~/1000}K coins',
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),).tr()
                                ),
                              )
                            ],
                          );
                    }),

                Utils.divider_50,

                Text("All that you will get with this package",textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColorLight),).tr(),

                Utils.dividerExtraLarge,

                GridView.builder(
                    itemCount: subscriptionPerks.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      childAspectRatio: 3
                    ),
                    itemBuilder: (_,index){
                      return Row(
                        children: [
                          Icon(subscriptionPerks[index]["icon"], color: subscriptionPerks[index]["color"],),
                          Utils.verticalDivider,
                          Flexible(child: Text(subscriptionPerks[index]["perk"], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)),
                        ],
                      );
                    }
                ),

                Utils.dividerExtraLarge,
              ],
            )
        ),

        BlocBuilder<SubscriptionCubit, int>(
            builder: (_,state){
              return state==-1
                  ? const SizedBox()
                  : Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
                        ]
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u20B9 ${SubscriptionViewModel.subscriptions[state].price}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                            Utils.verticalDividerMedium,
                            Text("For ${SubscriptionViewModel.subscriptions[state].period} plan", style: const TextStyle( fontSize: 12))
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: ()=>openCheckout(),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Utils.darkenColor(primaryColor),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: const Text( 'Proceed Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),).tr()
                          ),
                        )
                      ],
                    ),
                  );
            }
        ),
      ],
    );
  }

  void openCheckout() async {
    var options = {
      'key': razorpayKey,
      'amount': "${int.parse(SubscriptionViewModel.selectedPackage!.price)*100}",
      'name': Globals.name,
      'description': SubscriptionViewModel.selectedPackage!.name,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    BlocProvider.of<SubscriptionBloc>(context).add(
        SubscriptionSuccess(subscription: SubscriptionViewModel.selectedPackage!));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    BlocProvider.of<SubscriptionBloc>(context).add(
        SubscriptionFailure(subscription: SubscriptionViewModel.selectedPackage!));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {

  }
}

class SubscriptionListBuilder extends StatelessWidget {
  final bool isLoading;
  final List<Subscription>? subscriptions;
  const SubscriptionListBuilder({Key? key, required this.isLoading, this.subscriptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: isLoading ? 2 : subscriptions!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_,index)=> isLoading
            ? Container(
              padding: const EdgeInsets.all(10),
              child: const Loading(type: shimmer_2))
            : PriceItem(
                      index: index,
                      oldPrice: subscriptions![index].oldPrice,
                      period: subscriptions![index].period,
                      price: subscriptions![index].price,
                      validity: subscriptions![index].validity
                  )
    );
  }
}


