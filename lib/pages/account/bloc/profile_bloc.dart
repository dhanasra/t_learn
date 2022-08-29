import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/auth/model/UserData.dart';
import 'package:t_learn/utils/fb.dart';
import 'package:t_learn/utils/globals.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser!;

  ProfileBloc() : super(ProfileInitial()) {
    on<EditProfileEvent>(editProfile);
    on<GetProfile>(onGetProfile);
  }

  void onGetProfile(GetProfile event, Emitter emit) async {
    emit(ProfileLoading());
    UserData? data = await DB.getUserData();

    if(data!=null){
      emit(ProfileFetched(userData: data));
    }
  }

  void editProfile(EditProfileEvent event, Emitter emit) async{
    emit(Updating());

    Map<String, Object?> updateMap = {};

    updateMap["name"] = event.name;
    Globals.name = event.name;

    updateMap["gender"] = event.gender;
    updateMap["phone"] = event.phoneNumber;
    updateMap["city"] = event.city;

    if(event.photoUrl!=""){
      var photoPath = await uploadImage(event.photoUrl!);
      updateMap["photo"] = photoPath;
      Globals.photo = photoPath;
    }

    await DB.updateProfile(updateMap);

    emit(EditProfileSuccess());
  }

  Future<String> uploadImage(String path) async {
    Reference reference = FirebaseStorage.instance.ref().child(user.uid).child("profile_pic").child(path.split('/').last);
    await reference.putFile(File(path));
    return Future.value(await reference.getDownloadURL());
  }
}
