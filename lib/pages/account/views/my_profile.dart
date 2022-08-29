import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/account/bloc/profile_bloc.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/loading.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../widgets/custom_image.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        isBackPressed: true,
        title: "My Profile",
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, size: 26),
            onPressed: ()=>const App().setNavigation(context, AppRoutes.editProfile),
            splashRadius: 20,
          ),
        ],
        child: const SingleChildScrollView(
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
            CustomImage.decorated(width: 65, height: 65, isCircle: true, img: Globals.photo),
            const SizedBox(width: 30,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Full name", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),).tr(),
                    const Divider(color: Colors.transparent, height: 5,),
                    Text(Globals.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)
                  ],
                ),
            )
          ],
        ),
        const Divider(color: Colors.grey,height: 30,),

        BlocBuilder<ProfileBloc,ProfileState>(
            builder: (_,state){
              if(state is ProfileLoading){
                return Column(children: List.generate(3,
                        (index) => const Padding(padding: EdgeInsets.symmetric(vertical: 10),child:
                        Loading(type: shimmer_1),)));
              }else if(state is ProfileFetched){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Gender", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),).tr(),
                    Utils.dividerMedium,
                    Text(state.userData.gender??"-", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                    Utils.divider_35,
                    const Text("Email Address", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),).tr(),
                    Utils.dividerMedium,
                    Text(state.userData.email, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                    Utils.divider_35,
                    const Text("Phone number", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),).tr(),
                    Utils.dividerMedium,
                    Text(state.userData.phone??"-", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                    Utils.divider_35,
                    const Text("City", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey),).tr(),
                    Utils.dividerMedium,
                    Text(state.userData.city??"-", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                    Utils.divider_50
                  ],
                );
              }else{
                return const SizedBox();
              }
            })
      ],
    );
  }
}
