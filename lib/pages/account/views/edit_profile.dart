import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/pages/account/bloc/profile_bloc.dart';
import 'package:t_learn/pages/account/view_models/account_view_model.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/toaster.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/loading.dart';
import '../../chat/blocs/image_bloc/image_bloc.dart';

AccountViewModel viewModel = AccountViewModel();
String gender = "Male";
String pathFetched = "";

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        isBackPressed: true,
        padding: const EdgeInsets.all(20 ),
        title: "Edit Profile",
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (_,state){
            if(state is EditProfileSuccess){
              ScaffoldMessenger.of(context).showSnackBar(
                  Toaster.snack(content: "Profile updated successfully !")
              );
              const App().restart(context);
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (_,state)=> state is ProfileLoading || state is ProfileFetched,
              builder: (_,state){
                if(state is ProfileLoading){
                  return Column(children: List.generate(3,
                          (index) => const Padding(padding: EdgeInsets.symmetric(vertical: 10),child:
                      Loading(type: shimmer_1),)));
                }else if(state is ProfileFetched){

                  Future.delayed(const Duration(seconds: 0),(){
                    viewModel.nameController.text = state.userData.name;
                    viewModel.phoneNumberController.text = state.userData.phone??"";
                    viewModel.cityController.text = state.userData.city??"";
                    gender = state.userData.gender??gender;
                  });

                  return const MainBody();
                }else{
                  return const SizedBox();
                }
              }
          ),
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
                GestureDetector(
                  onTap: ()=>BlocProvider.of<ImageBloc>(context).add(GetImageEvent()),
                  child: BlocBuilder<ImageBloc, ImageState>(
                    builder: (_,state){
                      if(state is ImageFetched){
                        pathFetched = state.image.path;
                        return CustomImage.decorated(width: 65, height: 65, isCircle: true, file: state.image, img: Globals.photo);
                      }else{
                        return CustomImage.decorated(width: 65, height: 65, isCircle: true, img: Globals.photo);
                      }
                    },
                  ),
                ),
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

            Utils.verticalDividerExtraLarge,

            Expanded(
              child: TextField(
                  style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                  controller: viewModel.nameController,
                  decoration: const InputDecoration(
                      labelText: 'Full name',
                      prefixIcon: Icon(Icons.phone, size: 20,)
                  )
              )
            )
          ],
        ),


        Utils.divider_35,

        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              labelText: 'Gender',
              prefixIcon: Icon(Icons.transgender, size: 20,),
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: "Male",child: Text("Male")),
            DropdownMenuItem(value: "Female",child: Text("Female"))
          ],
          value: gender,
          onChanged: (val){
            gender = val!;
          },
        ),

        Utils.dividerExtraLarge,

        TextField(
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            controller: viewModel.phoneNumberController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone, size: 20,)
            )
        ),

        Utils.dividerExtraLarge,

        TextField(
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            controller: viewModel.cityController,
            decoration: const InputDecoration(
                labelText: 'City',
                prefixIcon: Icon(Icons.location_city, size: 20,)
            )
        ),

        const Spacer(),

        BlocBuilder<ProfileBloc,ProfileState>(
          buildWhen: (_,state)=>state is Updating || state is EditProfileSuccess,
          builder: (_,state) {
            return ElevatedButton(
                onPressed: () {
                  if(state is! Updating ){
                    BlocProvider.of<ProfileBloc>(context)
                        .add(EditProfileEvent(
                            phoneNumber: viewModel.phoneNumberController.text,
                            photoUrl: pathFetched,
                            gender: gender,
                            city: viewModel.cityController.text,
                            name: viewModel.nameController.text));
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),),
                child: state is! Updating
                  ? const Text('Update', style: TextStyle(fontSize: 14),).tr()
                  : const SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),)
            );
          })
      ],
    );
  }
}
