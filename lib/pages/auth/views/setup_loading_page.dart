import 'package:flutter/material.dart';

class SetupLoadingPage extends StatelessWidget {
  const SetupLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/setup_loading.gif', width: 100,),
              const Divider(color:Colors.transparent,height: 10,),
              Text("Setting up account . . .",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),),
            ],
          ),
        )
      );
  }
}
