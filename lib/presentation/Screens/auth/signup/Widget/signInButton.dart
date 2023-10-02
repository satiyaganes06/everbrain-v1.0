
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controller/signup_controller.getx.dart';

class SignInButton extends StatelessWidget {
  var formkey; 

  SignInButton(this.formkey,{Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: dimens.Dimens.delayAnimationSignUpPage),
      child: Material(
        color: colors.AppColor.primaryColor,
        borderRadius: BorderRadius.circular(dimens.Dimens.submitButtonContainerBorderSignUp),
        shadowColor: colors.AppColor.shadowColor,
        elevation: dimens.Dimens.submitButtonElevationSignUp,
        child: InkWell(
          onTap: (){
            if(formkey.currentState!.validate()){
              //signUpController.sigUpFun(context);
              signUpController.userDetectionFun(context);
            }
           
            
          },
          splashColor: colors.AppColor.splashColor,
          borderRadius: BorderRadius.circular(dimens.Dimens.submitButtonContainerBorderSignUp),
          child: SizedBox(
            width: double.infinity,
            height: dimens.Dimens.submitButtonContainerHeightSignUp,
            child: Center(
              child: Text( constants.Constants.submitButtonTitleSignUp,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color:colors.AppColor.secondaryColor,
                  fontSize: dimens.Dimens.submitButtonFontSizeSignUp
                ),
              )
            ),
          ),
        )
      ),
    );
  }
}