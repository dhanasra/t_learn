

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/account/bloc/theme/theme_bloc.dart';
import 'package:t_learn/pages/auth/model/UserData.dart';
import 'package:t_learn/pages/auth/model/course.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/date_utils.dart';
import 'package:t_learn/utils/fb.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/local_db.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<GoogleAuthEvent>(googleSignIn);
    on<SignupEvent>(signup);
    on<LoginEvent>(login);
    on<UserDetailsEvent>(addDetails);
    on<SaveInLocalDB>(onSaveInLocalDB);
    on<ForgotPasswordEvent>(forgotPassword);
  }

  void onSaveInLocalDB(SaveInLocalDB event, Emitter emit) async {
    emit(AuthLoading());

    UserData? data = await DB.getUserData();

      await LocalDB.save(LocalDBKeys.name, data?.name);
      await LocalDB.save(LocalDBKeys.exam, data?.exam);
      await LocalDB.save(LocalDBKeys.theme, data?.appTheme);
      await LocalDB.save(LocalDBKeys.appLang, data?.appLang);

      var examcode = await LocalDB.getExamCode();
      print(examcode);

      Globals.name = data!.name.split(" ")[0];
      Globals.exam = data.exam!.split("-")[0].toUpperCase();
      Globals.photo = data.photo ?? commonAvatar;
      Globals.coins = data.coins ?? "0";
      Globals.theme = data.appTheme;
      Globals.language = data.appLang;

      print(Globals.exam);

      bool? isPrime = data.isSubscribed;

      if (isPrime != null && isPrime && data.subscriptionValidity != null) {
        int today = DateTime
            .now()
            .millisecondsSinceEpoch;
        int validity = int.parse(data.subscriptionValidity!);

        if (today < validity) {
          Globals.isPrime = true;
        } else {
          Globals.isPrime = false;

          await DB.updateProfile({
            "isSubscribed": false,
            "subscriptionValidity": null
          });
        }
      } else {
        Globals.isPrime = false;
      }

      emit(SavedInLocalDB());
  }

  void addDetails(UserDetailsEvent event, Emitter emit) async {
    emit(AuthLoading());

    try{
      if(event.name.trim().isEmpty){
        emit(AuthFailure(message: getErrorMessage("unknown", param: "Name")));
      }else{
        User user = Auth().firebaseAuth.currentUser!;
        await user.updateDisplayName(event.name.trim());
        await DB.updateProfile({"name": event.name.trim()});
        emit(AuthSuccess());
      }
    }on FirebaseException catch(e){
      emit(AuthFailure(message: getErrorMessage(e.code)));
    }
  }

  void login(LoginEvent event, Emitter emit) async {
    emit(AuthLoading());
    try{
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email.trim(), password: event.password.trim());
      userCredential.user;
      emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
      String message = getErrorMessage(e.code, param: event.email.trim().isEmpty ? "Email address" : "Password");
      emit(AuthFailure(message: message));
    }
  }

  void signup(SignupEvent event, Emitter emit) async {
    emit(AuthLoading());
    try{

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: event.email.trim(), password: event.password.trim());

      await DB.setUpProfile(userCredential.user!);

      emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
      String message = getErrorMessage(e.code, param: event.email.trim().isEmpty ? "Email address" : "Password");
      emit(AuthFailure(message: message));
    }
  }

  void googleSignIn(GoogleAuthEvent event, Emitter emit) async{
    emit(AuthLoading());
    try{

      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      await DB.setUpProfile(userCredential.user!);

      emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
      emit(AuthFailure(message: getErrorMessage(e.code)));
    }on PlatformException catch(e){
      emit(AuthFailure(message: getErrorMessage(e.code)));
    }
  }

  void forgotPassword(ForgotPasswordEvent event, Emitter emit) async{
    emit(AuthLoading());
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
      emit(AuthSuccess());
    }on FirebaseException catch(e){
      emit(AuthFailure(message: getErrorMessage(e.code)));
    }
  }

  String getErrorMessage(String errorCode, {String? param}){
    switch(errorCode){
      case "unknown": return "$param is empty!";
      case "user-not-found": return "Sorry buddy, The email address not found";
      case "invalid-email": return "Please enter the valid email address";
      case "email-already-in-use": return "The given email address is already registered.";
      case "wrong-password": return "Wrong password";
      case "account-exists-with-different-credential": return "Email already associated with another account";
      case "weak-password": return "Password is too easy. Password should contain minimum 8 letters";
      case "operation-not-allowed": case "user-disabled": return "Something went wrong try different email address";
      default: return "Sorry buddy, Something went wrong. Try again later!";
    }
  }

}
