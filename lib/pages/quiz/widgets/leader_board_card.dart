import 'package:flutter/material.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';

import '../../../widgets/custom_image.dart';

class LeaderBoardCard extends StatelessWidget {
  final String name;
  final String photo;
  final String score;
  final String accuracy;
  final String rank;

  const LeaderBoardCard({
    Key? key,
    required this.name,
    required this.photo,
    required this.accuracy,
    required this.rank,
    required this.score
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),bottomLeft: Radius.circular(50),topRight: Radius.circular(8), bottomRight: Radius.circular(8)
        )
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CustomImage.decorated(width: 40, height: 40, isCircle: true, img: photo),
          Utils.verticalDivider,
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Utils.dividerSmall,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Accuracy", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                  Utils.verticalDividerMedium,
                  Container(
                    height: 5,
                    width: double.parse(accuracy),
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ],
              )
            ],
          )),
          Utils.verticalDividerMedium,
          Column(
            children: [
              Text(rank, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              Text("Score $score", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}
