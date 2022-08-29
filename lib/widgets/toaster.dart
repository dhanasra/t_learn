import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Toaster {

  static snack({
    required String content
  }){
    return SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Row(
          children: [
            Image.asset('assets/images/man.png', width: 40, height: 40,),
            Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                  child: Text(
                    content,
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.4,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ).tr(),
                )
            )
          ],
        ),
    );
  }

}