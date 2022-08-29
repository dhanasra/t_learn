import 'dart:math';

import 'package:flutter/material.dart';

import '../pages/quiz/model/result.dart';

abstract class Utils {

  static const duration_1 =  Duration(seconds: 2);

  static const verticalDividerMedium = VerticalDivider(color: Colors.transparent, width: 8);
  static const verticalDividerSmall = VerticalDivider(color: Colors.transparent, width: 4);
  static const verticalDivider = VerticalDivider(color: Colors.transparent);
  static const verticalDividerLarge = VerticalDivider(color: Colors.transparent, width: 20);
  static const verticalDividerExtraLarge = VerticalDivider(color: Colors.transparent, width: 24);
  static const verticalDivider_30 = VerticalDivider(color: Colors.transparent, width: 30);
  static const verticalDivider_50 = VerticalDivider(color: Colors.transparent, width: 50);

  static const dividerMedium = Divider(color: Colors.transparent, height: 8);
  static const dividerSmall = Divider(color: Colors.transparent, height: 4);
  static const divider = Divider(color: Colors.transparent);
  static const dividerLarge = Divider(color: Colors.transparent, height: 20);
  static const dividerExtraLarge = Divider(color: Colors.transparent, height: 24);
  static const divider_35 = Divider(color: Colors.transparent, height: 35);
  static const divider_50 = Divider(color: Colors.transparent, height: 50);

  static const buttonProgressIndicator = SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2));

  static Color darkenColor(Color color, [double amount = 0.30]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static MaterialColor materialColor(Color color){

    Map<int, Color> materialColorMap = {
      50: color.withOpacity(0.1),
      100:color.withOpacity(0.2),
      200:color.withOpacity(0.3),
      300:color.withOpacity(0.4),
      400:color.withOpacity(0.5),
      500:color.withOpacity(0.6),
      600:color.withOpacity(0.7),
      700:color.withOpacity(0.8),
      800:color.withOpacity(0.9),
      900:color.withOpacity(1.0),
    };

    return MaterialColor(color.value, materialColorMap);
  }

  static Color getRandomColor(){
    Random rand = Random();
    return Color.fromRGBO(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256), 1);
  }


  static double getMax(List<Result> results){
    return results.map<double>((item) => double.parse(item.timeTaken)/100).reduce(max);
  }
}