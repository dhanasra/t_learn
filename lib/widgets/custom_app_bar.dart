import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomAppBar {

  static Widget leadingIcon() {
    return IconButton(
      icon: const Icon(Icons.keyboard_arrow_left_rounded, color: primaryColor, size: 34,),
      onPressed: (){},
      splashRadius: 20,
    );
  }

  static Widget actionIcon(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child:IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        splashRadius: 20,
      ),
    );
  }

  static Widget title(String title){
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w600,
      ),
    );
  }

}
