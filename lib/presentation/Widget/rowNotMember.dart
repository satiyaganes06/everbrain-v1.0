
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;

import '../../presentation/Screens/auth/signup/signup_Screen.dart';



class RowNotMember extends StatelessWidget {
  const RowNotMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: dimens.Dimens.delayAnimationLogInPage),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(constants.Constants.notAmemberSubtextLogIn,
            style: GoogleFonts.poppins(
              fontSize: dimens.Dimens.notAmemberSubtextFontSize,
              fontWeight: FontWeight.w600
            ),
          ),
            TextButton(
            onPressed: (){
              Get.to(()=> SignUpScreen());
            }, 
            child: Text(constants.Constants.submitButtonTitleSignUp,
              style: GoogleFonts.poppins(
                color: colors.AppColor.primaryColor,
                fontSize: dimens.Dimens.notAmemberButtonFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      )
    );
  }
}