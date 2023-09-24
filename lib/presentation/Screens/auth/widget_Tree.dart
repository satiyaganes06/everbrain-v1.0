import 'package:everbrain/controller/local_auth_controller.getx.dart';
import 'package:everbrain/presentation/Screens/auth/emailVerification/email_verify_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../controller/email_verify_controller.getx.dart';
import '../../../controller/login_controller.getx.dart';
import '../../../controller/setting_controller.getx.dart';
import '../../../core/localServices/secure_storage_repository.dart';
import '../../../core/networkService/firebase_service.dart';
import 'local_auth/local_auth_screen.dart';
import 'login/loginScreen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  final loginController = Get.put(LoginController());
  final emailVerify = Get.put(EmailVerifyController());
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder( 
      stream: FirebaseService().authStateChanges,
      builder: ((context, snapshot){
      if(snapshot.hasData) {

          final settingContrl = Get.put(SettingController());
          final localAuthContrl = Get.put(LocalAuthController());
        //  final alreadyLog = Get.put(AlreadyLogInController());

         // alreadyLog.isEmailVerifyFun();
          GetIt.I.get<LocalStorageSecure>().saveString('userID', snapshot.data!.uid); 
        
          if(snapshot.data!.emailVerified == true){
            
            return LocalAuthScreen();

          }else{
            
            return const VerifyEmailScreen();

          }

        }else{

          return LoginScreen();
          
        }
      }),
    );
  }
}