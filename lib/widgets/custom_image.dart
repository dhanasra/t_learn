import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';

class CustomImage {

  static Widget decorated({
    required double width,
    required double height,
    required bool isCircle,
    required String img
  }){
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isCircle ? circle : blunt),
          boxShadow: const [
            BoxShadow(color: Color(0xFFF0F0F0), spreadRadius: 4),
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isCircle ? circle : blunt),
        child: Image.asset('assets/images/$img',width: width,height: height,fit: BoxFit.cover,),
      ),
    );
  }


}