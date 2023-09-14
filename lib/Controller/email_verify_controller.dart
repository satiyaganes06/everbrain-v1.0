
import 'dart:async';

import 'package:everbrain/presentation/Screens/dashboard/dashboard_Screen.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'login_controller.dart';
import 'package:everbrain/utils/colors.dart' as colors;

class EmailVerifyController extends GetxController{

  final loginController = Get.find<LoginController>();

  RxBool isEmailVerified = false.obs;
  RxBool canResentEmail = false.obs;
  Timer? timer;

  void requestEmailVerificationFunction() {
    isEmailVerified.value = loginController.getfirebaseService.currentUser!.emailVerified;

    if(isEmailVerified.value == false){
      loginController.firebaseService.sendVerificationEmail(canResentEmail);

      timer = Timer.periodic(const Duration(seconds: 3), (timer) { 
        loginController.firebaseService.checkEmailVerified(isEmailVerified);
        
        if(isEmailVerified.value) timer.cancel();
      });
      
    }
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


}