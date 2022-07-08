import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onClick;
  final bool isRounded;

  const CustomButton({
    Key? key,
    required this.onClick,
    required this.btnText,
    this.isRounded = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isRounded ? circle : blunt)
          )
      ),
      child: Text(btnText,),
    );
  }

  static Widget secondary({
    bool isRounded = false,
    required VoidCallback onClick,
    required String btnText
  }){

    return ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isRounded ? circle : blunt),
              side: const BorderSide(color: primaryColor, width: 1)
          )
      ),
      child: Text(btnText),
    );
  }
}
