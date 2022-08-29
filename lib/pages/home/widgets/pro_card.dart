import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';

class ProCard extends StatelessWidget {
  const ProCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFDDDDDD),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
          ]
      ),
      child: InkWell(
        onTap: ()=>const App().setNavigation(context, AppRoutes.subscription),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("More than 3000+",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Utils.darkenColor(primaryColor)
                    )).tr(),

                    Utils.dividerSmall,

                    Text("Questions, Materials & tests",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).appBarTheme.backgroundColor
                    )).tr(),

                    Utils.dividerSmall,

                    Text("for Exam",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Theme.of(context).canvasColor
                    )),

                    Utils.dividerLarge,

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Utils.darkenColor(primaryColor),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: const Text( 'Upgrade Now', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),).tr(),

                    )
                  ],
                )),
            Image.asset("${appAssets}prop.png", height: 100,)
          ],
        ),
      ),
    );
  }
}
