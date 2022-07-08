

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<GoogleAuthEvent>(googleSignIn);
    on<SignupEvent>(signup);
    on<LoginEvent>(login);
    on<UserDetailsEvent>(addDetails);
    on<ForgotPasswordEvent>(forgotPassword);
  }

  void addDetails(UserDetailsEvent event, Emitter emit) async {
    emit(AuthLoading());

    try{
      if(event.name.trim().isEmpty){
        emit(AuthFailure(message: getErrorMessage("unknown", param: "Name")));
      }else{
        User user = FirebaseAuth.instance.currentUser!;
        await user.updateDisplayName(event.name.trim());
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
      userCredential.user;
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
      userCredential.user;
      emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
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
    print(errorCode);
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
