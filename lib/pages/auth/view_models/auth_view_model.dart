import 'package:flutter/cupertino.dart';

import '../model/course.dart';

class AuthViewModel {

  static late AuthViewModel _instance;
  factory AuthViewModel() {
    _instance = AuthViewModel._internal();
    return _instance;
  }
  AuthViewModel._internal() {
    _init();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;

  static Course? selectedCourse;


  void _init(){

    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();

  }

  void clearInputs(){
    emailController.text = "";
    passwordController.text = "";
    nameController.text = "";
  }

}