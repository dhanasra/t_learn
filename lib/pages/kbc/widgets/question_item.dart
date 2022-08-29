import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class QuestionItem extends StatelessWidget {
  final String question;
  final String amount;
  const QuestionItem({
    Key? key,
    required this.question,
    required this.amount
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20,25,20,20),
          margin: const EdgeInsets.fromLTRB(50, 20, 50, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(blunt),
              border: Border.all(color: secondaryColor, width: 2),
              color: Colors.white
          ),
          child: Text(question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 14
          )),
        ),
        Positioned(
          child:Container(
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                  gradient: appGradient3,
                  borderRadius: BorderRadius.circular(blunt)
              ),
              alignment: Alignment.center,
              child: Text("\u20B9 $amount",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Freshman',
                    fontSize: 14,
                  ))
          ),
        ),
      ],
    );
  }
}
