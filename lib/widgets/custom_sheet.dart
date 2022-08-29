import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/utils/fb.dart';

import 'custom_button.dart';


class CustomSheet {

  static showLogout(BuildContext context){

    showModalBottomSheet(
      shape: const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(
          top: Radius.circular(25) ),),
      backgroundColor: Theme.of(context).cardColor, context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                const Divider(color: Colors.transparent, height: 30,),
                const Text("Do you really want to logout?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                const Divider(color: Colors.transparent,height: 30,),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                          height: 45,
                          child: CustomButton(onClick: () async {
                            await Auth().firebaseAuth.signOut().then((value){
                              const App().restart(context);
                            });
                          }, btnText: "Yes"),
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        child: SizedBox(
                          height: 45,
                          child: CustomButton.secondary(onClick: ()=>Navigator.pop(context), btnText: "No"),
                        )
                    )
                  ],
                )
              ],
            ),
        );
      },
    );
  }
}