import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/networkService/firebase_service.dart';


class LoginController extends GetxController{
  
  final email_field = TextEditingController();
  final password_field = TextEditingController();
  bool passwordToggle = true;
  
  FirebaseService firebaseService = FirebaseService();
  get getfirebaseService => firebaseService;

  funPasswordToggle(){
    passwordToggle = !passwordToggle;
    update();
  }

  
  

}