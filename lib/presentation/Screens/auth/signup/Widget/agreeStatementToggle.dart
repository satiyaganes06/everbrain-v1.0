
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controller/signup_controller.getx.dart';
import '../term_agreement_screen.dart';

class AgreementStatementToggle extends StatelessWidget {
  AgreementStatementToggle({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (_) =>
      DelayedDisplay(
        delay: Duration(milliseconds: dimens.Dimens.delayAnimationSignUpPage),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            FlutterSwitch(
              width: dimens.Dimens.agreementToggleWidth,
              height: dimens.Dimens.agreementToggleHight,
              activeColor: colors.AppColor.primaryColor,
              inactiveColor: colors.AppColor.lightGrey,
              toggleColor: colors.AppColor.secondaryColor,
              value: signUpController.isAgree,
              onToggle: (val) {
                signUpController.agreeStatementToggle();
              },
            ),

            TextButton(
              onPressed: (){
                Get.to(TermAndAgreementScreen());
              },
              child: Text(constants.Constants.agreementStatementSignUp, style: GoogleFonts.poppins(
                color: colors.AppColor.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: dimens.Dimens.agreementToggleFontSizeSignUp
              )), 
            ),
          ]
        )
      )
    );
  }

  
}