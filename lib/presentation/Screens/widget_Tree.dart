import 'package:everbrain/presentation/Screens/dashboard_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/email_verify_controller.dart';
import '../../Controller/flutter_encry_controller.dart';
import '../../Controller/login_controller.dart';
import '../../core/networkService/firebase_service.dart';
import 'auth/login/loginScreen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  final loginController = Get.put(LoginController());
  final emailVerifyController = Get.put(EmailVerifyController());
  final encryController = Get.put(FlutterEncryController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder( 
      stream: FirebaseService().authStateChanges,
      builder: ((context, snapshot) {
        if(snapshot.hasData){
          return const DashboardScreen();
          // if(emailVerifyController.isEmailVerified.value == true){
          //   return const DashboardScreen();
          // }else{
          //   return LoginScreen();
          // }

        }else{

          return LoginScreen();
          
        }
      }),
    );
  }
}