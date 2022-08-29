import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class QuizResultItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String content;
  final String noOfQuestions;

  const QuizResultItem({
    Key? key,
    required this.content,
    required this.icon,
    required this.iconColor,
    required this.noOfQuestions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon,color: iconColor,size: 16,),
          const SizedBox(width: 15,),
          Text(noOfQuestions, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)).tr(),
          const SizedBox(width: 3,),
          Text(content, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)).tr()
        ],
      ),
    );
  }
}
