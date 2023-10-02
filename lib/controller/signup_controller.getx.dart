import 'package:everbrain/presentation/widget/global_widget.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../core/networkService/hms_respository.dart';
import 'login_controller.getx.dart';

class SignUpController extends GetxController {
  final loginController = Get.find<LoginController>();

  final passwordHints = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final repasswordField = TextEditingController();

  bool passwordToggle = true;
  bool isAgree = false;

  funPasswordToggle() {
    passwordToggle = !passwordToggle;
    update();
  }

  void agreeStatementToggle() {
    isAgree = !isAgree;
    update();
  }

  void sigUpFun(BuildContext context) {
    loginController.firebaseService.signUp(emailField.text, passwordField.text,
        passwordHints.text, isAgree, context);
  }

  bool isHintValid() {
    // User input: Password and Hint
    String password = "12345LOga@";
    String hint = "Loga 1 2";

    // Split the password into words
    List<String> passwordWords = password.split(RegExp(r'\s+'));

    // Split the hint into words
    List<String> hintWords = hint.split(RegExp(r'\s+'));

    // Check if the hint contains more than two consecutive words from the password
    bool hasConsecutiveWords = false;
    for (int i = 0; i < hintWords.length - 2; i++) {
      String consecutiveWords = hintWords.sublist(i, i + 3).join(' ');
      if (password.contains(consecutiveWords)) {
        hasConsecutiveWords = true;
        break;
      }
    }

    // Display an error message if the condition is met
    if (hasConsecutiveWords) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> userDetectionFun(BuildContext context) async {
    if (isAgree) {
      await GetIt.I.get<HmsRepository>().userDetection().then((token) {
        if (token != null) {
          sigUpFun(context);
        } else {
          failMessage(context, 'User not verified');
        }
      });
    } else {
      failMessage(context, 'Agree to the terms and conditions');
    }
  }

  @override
  void dispose() {
    passwordHints.dispose();
    emailField.dispose();
    passwordField.dispose();
    repasswordField.dispose();
    isAgree = false;
    passwordToggle = true;

    super.dispose();
  }
}
