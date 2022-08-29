import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/pages/auth/model/course.dart';

import '../../../utils/utils.dart';

class ExamItem extends StatelessWidget {
  final Course course;
  final ValueChanged<Course> onClick;
  const ExamItem({
    Key? key,
    required this.course,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
          ]
      ),
      child: GestureDetector(
        onTap: ()=>onClick(course),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.1,
              child: CachedNetworkImage(imageUrl: course.icon),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(course.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                Utils.dividerMedium,
                Text(course.lang, style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w600, fontSize: 12))
              ],
            )
          ],
        ),
      ),
    );
  }
}
