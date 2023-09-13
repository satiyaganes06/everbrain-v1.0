import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Controller/signup_controller.dart';

class ConfirmMasterPasswordField extends StatelessWidget {
  ConfirmMasterPasswordField({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: dimens.Dimens.delayAnimationSignUpPage),
      child: SizedBox(
        width: dimens.Dimens.confirmMasterPasswordContainerWidthSignUp,
        child: TextFormField(
          controller: signUpController.repasswordField,
          keyboardType: TextInputType.emailAddress,
          cursorColor: colors.AppColor.primaryColor,
          obscureText: true,
          decoration: InputDecoration(
            filled: true, 
            fillColor: colors.AppColor.lightGrey,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(dimens.Dimens.confirmMasterPasswordContainerBorderSignUp),
            ),
            hintText: constants.Constants.confirmMasterPasswordFieldSignUp,
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: dimens.Dimens.confirmMasterPasswordFontSizeSignUp,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: dimens.Dimens.confirmMasterPasswordContentHorizontalPaddingSignUp, 
              vertical: dimens.Dimens.confirmMasterPasswordContentVerticalPaddingSignUp
            ),
            
            
          ),
          validator: (value){
            print(signUpController.passwordField.text.toString() + " " + signUpController.repasswordField.text.toString());
            if(value != signUpController.passwordField.text.toString()){
              return constants.Constants.confirmMasterPasswordFieldErrorSignUp;
            }else{
              return null;
            }
            
          },
        )
      )
    );
  }
}