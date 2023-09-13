
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';


class SignUpController extends GetxController{

  final loginController = Get.find<LoginController>();

  final passwordHints = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final repasswordField = TextEditingController();

  bool passwordToggle = true;
  bool isAgree = false;

  funPasswordToggle(){
    passwordToggle = !passwordToggle;
    update();
  }

  void agreeStatementToggle(){
    isAgree = !isAgree;
    update();
  }


}