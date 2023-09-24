
import 'dart:async';
import 'package:everbrain/controller/login_controller.getx.dart';
import 'package:get/get.dart';

import '../presentation/Screens/auth/emailVerification/email_verify_Screen.dart';
import '../presentation/Screens/dashboard/dashboard_Screen.dart';

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

  isEmailVerifyFun() async{

    isEmailVerified.value = await loginController.firebaseService.currentUserEmailVerifiedStatus();

  }




  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }


}