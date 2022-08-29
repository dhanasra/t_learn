import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/utils/utils.dart';

class QuizInfoItem extends StatelessWidget {
  final String infoKey;
  final String infoValue;
  final IconData infoIcon;
  const QuizInfoItem({
    Key? key,
    required this.infoIcon,
    required this.infoKey,
    required this.infoValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            Icon(infoIcon, color: Colors.deepPurple, size: 30,),
            Utils.divider,
            Text(infoValue, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)).tr(),
            Utils.dividerSmall,
            Text(infoKey, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),).tr(),
          ],
        )
    );
  }
}
