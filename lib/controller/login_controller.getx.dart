import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../core/networkService/firebase_service.dart';
import '../core/networkService/hms_respository.dart';
import '../presentation/Widget/global_widget.dart';

class LoginController extends GetxController {
  final email_field = TextEditingController();
  final password_field = TextEditingController();
  bool passwordToggle = true;

  FirebaseService firebaseService = FirebaseService();
  get getfirebaseService => firebaseService;

  funPasswordToggle() {
    passwordToggle = !passwordToggle;
    update();
  }

  Future<void> userDetectionFun(BuildContext context) async {
    await GetIt.I.get<HmsRepository>().userDetection().then((token) {
      if (token != null) {
        firebaseService.signIn(email_field.text, password_field.text, context);
      } else {
        failMessage(context, 'User not verified');
      }
    });
  }

  @override
  void dispose() {
    password_field.dispose();
    super.dispose();
  }
}
