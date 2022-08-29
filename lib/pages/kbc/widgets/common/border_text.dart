

import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class BorderedText extends StatelessWidget {
  const BorderedText({
    Key? key,
    required this.text,
    this.strokeCap = StrokeCap.round,
    this.strokeJoin = StrokeJoin.round,
    this.strokeWidth = 6.0,
    this.strokeColor = const Color.fromRGBO(53, 0, 71, 1),
    this.offset = 0.0,
    this.fontSize = 65
  }) : super(key: key);

  final double offset;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final double strokeWidth;
  final Color strokeColor;
  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.translate(
          offset: Offset(offset, offset),
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize??65,
                fontWeight: FontWeight.w100,
                color: primaryColor,
                fontFamily: 'Freshman'
            ).copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeCap = strokeCap
                ..strokeJoin = strokeJoin
                ..strokeWidth = strokeWidth
                ..color = strokeColor,
              color: null,
            ),
          ),
        ),
        Text(text, style: TextStyle(
            fontSize: fontSize??65,
            fontWeight: FontWeight.w100,
            color: primaryColor,
            fontFamily: 'Freshman'
        )
        ),
      ],
    );
  }
}