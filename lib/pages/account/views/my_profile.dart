import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_image.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CustomAppBar.leadingIcon(),
          title: CustomAppBar.title("My Profile"),
          actions: [ CustomAppBar.actionIcon(FontAwesomeIcons.penFancy, ()=>const App().setNavigation(context, AppRoutes.editProfile)) ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.deepPurpleAccent,
        ),
        backgroundColor: Colors.white,
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: MainBody(),
        )
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomImage.decorated(width: 65, height: 65, isCircle: true, img: "profile_pic.jpeg"),
            const SizedBox(width: 30,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Full name", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),),
                    Divider(color: Colors.transparent, height: 5,),
                    Text("Dhana Sekaran", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),)
                  ],
                ),
            )
          ],
        ),
        const Divider(color: Colors.grey,height: 30,),
        const Text("Gender", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),),
        const SizedBox(height: 5,),
        const Text("Male", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
        const Divider(color: Colors.transparent, height: 30,),
        const Text("Email Address", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),),
        const SizedBox(height: 5,),
        const Text("1dhana625@gmail.com", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
        const Divider(color: Colors.transparent, height: 30,),
        const Text("Phone number", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),),
        const SizedBox(height: 5,),
        const Text("8056384773", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
        const Divider(color: Colors.transparent, height: 30,),
        const Text("City", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),),
        const SizedBox(height: 5,),
        const Text("Trichy", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
        const Divider(color: Colors.transparent, height: 30,),
        const Divider(color: Colors.transparent,height: 30,),
      ],
    );
  }
}
