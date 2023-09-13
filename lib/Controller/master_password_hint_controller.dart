
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:get/get.dart';
import 'package:mailer/smtp_server.dart';

import 'login_controller.dart';

class MasterPassswordHintController extends GetxController{

  final loginController = Get.find<LoginController>();
  final emailTextController = TextEditingController();

  Future sendHintToEmail() async{

    final hint = 'loginController.firebaseService.getUserHints()';
    
   var smtp = gmailSaslXoauth2(emailTextController.text.toString(), 'LogaVance_1203');
    final message = Message()
    ..from = Address(emailTextController.text.toString())
    ..recipients = ['satiyaganes@gmail.com']
    ..subject = "Your Master Password Hint"
    ..text = """
        You (or someone) recently requested your master password hint.<br>
        Your hint is: "$hint"<br>
        If you still cannot remember your master password, please refer to the following article for your options:
        sgdeveloper@gmail.com <br>
        If you did not request your master password hint you can safely ignore this email.""";

        try {
          await send(message, smtp);
            Get.snackbar('SuccessFully send email', 
            "Check your email for hint",
            backgroundColor: colors.AppColor.success,
            colorText: colors.AppColor.secondaryColor,
            snackPosition: SnackPosition.BOTTOM);
        } catch (e) {
          debugPrint(e.toString());
          Get.snackbar('Error', 
            e.toString(),
            backgroundColor: colors.AppColor.fail,
            colorText: colors.AppColor.secondaryColor,
            snackPosition: SnackPosition.BOTTOM);
        }
  }
}