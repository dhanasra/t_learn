import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("There are no materials", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),).tr(),
          const Text("saved yet !", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),).tr(),
          Utils.dividerExtraLarge,
          const Icon(FontAwesomeIcons.boxOpen, size: 50, color: primaryColor,),
          Utils.dividerExtraLarge,
          Text("Explore all materials from home !", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Theme.of(context).canvasColor.withOpacity(0.6)),).tr(),
        ],
      ),
    );
  }
}
