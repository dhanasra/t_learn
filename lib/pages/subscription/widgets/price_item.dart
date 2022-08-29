import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/subscription/cubit/subscription_cubit.dart';
import 'package:t_learn/pages/subscription/view_model/subscription_view_model.dart';
import 'package:t_learn/utils/constants.dart';

import '../../../utils/utils.dart';

class PriceItem extends StatelessWidget {
  final String period;
  final String validity;
  final String oldPrice;
  final String price;
  final int index;

  const PriceItem({
    Key? key,
    required this.oldPrice,
    required this.period,
    required this.price,
    required this.validity,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, int>(
        builder: (_,state){
          return Padding(
            padding: const EdgeInsets.symmetric( vertical: 10),
            child: ListTile(
              onTap: (){
                SubscriptionViewModel.selectedPackage = SubscriptionViewModel.subscriptions[index];
                BlocProvider.of<SubscriptionCubit>(context).choosePackage(index);
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: index==state ? Utils.darkenColor(primaryColor) : Theme.of(context).canvasColor.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(4)
              ),
              title: Text("For $period", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              subtitle: Text("Valid till $validity", style: const TextStyle(fontSize: 12)),
              minLeadingWidth: 20,
              trailing:Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("\u20B9 $oldPrice", style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12)),
                  Utils.verticalDividerMedium,
                  Text("\u20B9 $price", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
              ),
              leading: Icon(index==state ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.circle, size: 16, color:index==state ? Utils.darkenColor(primaryColor) : Theme.of(context).canvasColor.withOpacity(0.6),),
            ),
          );});
  }
}
