import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String option;
  final bool isPrimary;
  final VoidCallback onClick;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.option,
    required this.onClick,
    this.isPrimary = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(blunt),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(blunt)
        ),
        child: Icon(icon, color: isPrimary ? Colors.deepOrangeAccent : primaryColor, size: 18,),
      ),
      title: Text(
        option,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: isPrimary ? Colors.deepOrangeAccent : null
        ),
      ).tr(),
      trailing: Container(
        padding: const EdgeInsets.all(blunt),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(circle)
        ),
        child: Icon(Icons.keyboard_arrow_right_rounded, color: isPrimary ? Colors.deepOrangeAccent : tcBlack, size: 18,),
      ),
      onTap: onClick,
    );
  }
}
