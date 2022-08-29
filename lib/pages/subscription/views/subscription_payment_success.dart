import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/pages/subscription/view_model/subscription_view_model.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';

class SubscriptionPaymentSuccess extends StatelessWidget {
  const SubscriptionPaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{
          const App().restart(context);
          return false;
        },
        child: const Background(
          child: MainBody(),
        )
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              Text("Payment successful !",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, height: 1.5, color: Utils.darkenColor(primaryColor))),

              const Text("Welcome to the team"),

              Utils.divider_50,

              Align(
                alignment: Alignment.center,
                child: SizedBox(width: 200, child: Image.asset("${appAssets}success.png"))),

              Utils.dividerExtraLarge,

              const Text("Package details",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),

              Utils.dividerExtraLarge,

              Table(
                border:TableBorder.all(width: 1.0,color: primaryColor),
                children: [
                  TableRow(
                    children: [
                      const Padding(padding: EdgeInsets.all(10),child: Text("Name"),),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(SubscriptionViewModel.selectedPackage!.name),
                      ),
                    ]
                  ),
                  TableRow(
                      children: [
                        const Padding(padding: EdgeInsets.all(10),child: Text("Period"),),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(SubscriptionViewModel.selectedPackage!.period),
                        ),
                      ]
                  ),
                  TableRow(
                      children: [
                        const Padding(padding: EdgeInsets.all(10),child: Text("Price"),),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("\u20B9 ${SubscriptionViewModel.selectedPackage!.price}"),
                        ),
                      ]
                  ),
                  TableRow(
                      children: [
                        const Padding(padding: EdgeInsets.all(10),child: Text("Ends At"),),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(SubscriptionViewModel.selectedPackage!.validity),
                        ),
                      ]
                  ),
                ],
              )

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
              onPressed: ()=>const App().restart(context),
              style: ElevatedButton.styleFrom( minimumSize: const Size(double.infinity, 50)),
              child:  const Text( "Let's Start")
          ),
        )
      ],
    );
  }
}
