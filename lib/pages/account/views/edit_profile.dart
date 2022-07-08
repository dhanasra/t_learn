import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_image.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CustomAppBar.leadingIcon(),
          title: CustomAppBar.title("My Profile"),
          actions: [ CustomAppBar.actionIcon(Icons.segment,(){}) ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.deepPurpleAccent,
        ),
        backgroundColor: Colors.white,
        body: const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 20),
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
      children: [
        Row(
          children: [
            Stack(
              children: [
                CustomImage.decorated(width: 65, height: 65, isCircle: true, img: "profile_pic.jpeg"),
                Positioned( bottom: 0, right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(circle)
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 12,),
                    )
                )
              ],
            ),
            SizedBox(width: 30,),
            Expanded(
              child: Column(
                children: [
                  TextField(
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0),
                      prefixIcon: Icon(FontAwesomeIcons.solidUser, size: 18,),
                      labelText: 'Full Name',
                    ),
                  ),
                  Divider(color: Colors.transparent,height: 30,),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(blunt-4),
                              border: Border.all(color: Colors.black.withOpacity(0.1), width: 1)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.person, color: Colors.black.withOpacity(0.5),),
                              SizedBox(
                                width: 60,
                                child: Center(
                                  child: Text('Male',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      Spacer(),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(blunt-4),
                              border: Border.all(color: Colors.black.withOpacity(0.1), width: 1)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.personDress, color: Colors.black.withOpacity(0.5),),
                              SizedBox(
                                width: 60,
                                child: Center(
                                  child: Text('Female',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )
            )
          ],
        ),
        Divider(color: Colors.transparent,height: 30,),
        TextField(
          autofocus: false,
          style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 0),
            prefixIcon: Icon(Icons.email, size: 20,),
            labelText: 'Email address',
          ),
        ),
        Divider(color: Colors.transparent, height: 30,),
        TextField(
          autofocus: false,
          style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 0),
            prefixIcon: Icon(Icons.phone, size: 20,),
            labelText: 'Phone number',
          ),
        ),
        Divider(color: Colors.transparent,height: 30,),
        TextField(
          autofocus: false,
          style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 0),
            prefixIcon: Icon(Icons.location_city, size: 20,),
            labelText: 'City',
          ),
        ),
        Spacer(),
        ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom( minimumSize: Size(double.infinity, 50), ),
            child: Text( 'Update', style: TextStyle( fontSize: 14 ),)
        )
      ],
    );
  }
}
