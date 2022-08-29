import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/utils/utils.dart';

import '../../../utils/constants.dart';

class PaymentFailureBottomSheet extends StatelessWidget {
  const PaymentFailureBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Payment Failed", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          Utils.divider_50,
          const Text("Do you want to try again?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
          Utils.dividerExtraLarge,
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                    onTap: ()=>const App().setBackNavigation(context),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Utils.darkenColor(primaryColor),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: const Text( 'Yes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),).tr()
                    ),
                  )
              ),
              const SizedBox(width: 20,),
              Expanded(
                  child: GestureDetector(
                    onTap: ()=>const App().setNavigation(context, AppRoutes.home),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Utils.darkenColor(primaryColor))
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text( 'No', style: TextStyle(color: Utils.darkenColor(primaryColor), fontWeight: FontWeight.w500),).tr()
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
