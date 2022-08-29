import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/widgets/background.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No Internet", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),),
            const Text("Please connect to internet", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
            Image.asset("${appAssets}no_internet.png"),
            ElevatedButton(
                onPressed: ()=>const App().restart(context),
                style: ElevatedButton.styleFrom( minimumSize: const Size(120, 50)),
                child: const Text( 'Retry')
            )
          ],
        ));
  }
}
