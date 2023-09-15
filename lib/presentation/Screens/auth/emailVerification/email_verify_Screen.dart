import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/presentation/Screens/dashboard/dashboard_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:lottie/lottie.dart';
import '../../../../controller/email_verify_controller.getx.dart';
import '../../../../controller/login_controller.getx.dart';
import '../../../Widget/space.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  
  final loginController = Get.find<LoginController>();
  final emailVerifyController = Get.find<EmailVerifyController>();

  @override
  Widget build(BuildContext context) {
    
    emailVerifyController.requestEmailVerificationFunction();

    return Obx((){
      return emailVerifyController.isEmailVerified.value ? const DashboardScreen() : verifyScreen();
    });
  }

  verifyScreen(){
    return Scaffold(
      backgroundColor: colors.AppColor.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[

                Space(Get.height*0.1),

                DelayedDisplay(
                delay: const Duration(milliseconds:230),
                  child: Lottie.asset(
                    'assets/lottie/email_verification_animation.json',
                    width: Get.width * 0.8
                  ),

                ),
                
                DelayedDisplay(
                delay: const Duration(milliseconds:230),
                  child: Text(
                    'A verification email has been send to your email',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colors.AppColor.accentColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2
                  ),
                ),

                DelayedDisplay(
                delay: const Duration(milliseconds:230),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Did check your Spam Folder ?',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.fail,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2
                    ),
                  ),
                ),

                Space(Get.height*0.05),

                DelayedDisplay(
                delay: const Duration(milliseconds:230),
                  child: Material(
                    color: emailVerifyController.canResentEmail.value ? colors.AppColor.primaryColor : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: colors.AppColor.shadowColor,
                    elevation: 6.1,
                    child: InkWell(
                      onTap: (){
                        emailVerifyController.canResentEmail.value ?
                        loginController.firebaseService.sendVerificationEmail(emailVerifyController.canResentEmail):
                        null;
                      },
                      enableFeedback: emailVerifyController.canResentEmail.value ? true:false ,
                      borderRadius: BorderRadius.circular(10),
                      splashColor: emailVerifyController.canResentEmail.value ? colors.AppColor.splashColor : Colors.grey,
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.email,
                                  color: colors.AppColor.secondaryColor,
                                )
                              ),
                                Text('Resent Email' ,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: colors.AppColor.secondaryColor
                                  ),
                              ),
                            ]
                          )
                        ),
                    )
                  )
                )
              )
            ] 
          )
        )
      )
    );
  }
}



