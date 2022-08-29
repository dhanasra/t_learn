import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/utils/constants.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String option;
  final bool isPrimary;
  final VoidCallback onClick;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.option,
    required this.onClick,
    this.isPrimary = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
          leading: Image.asset("$appAssets$icon", width: 30,),
          title: Text(option, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)).tr(),
          trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Theme.of(context).appBarTheme.foregroundColor, size: 18,),
          onTap: onClick
      ),
    );
  }
}
