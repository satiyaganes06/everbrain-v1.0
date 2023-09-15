
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controller/signup_controller.getx.dart';

class MasterPasswordHint extends StatelessWidget {
  MasterPasswordHint({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: dimens.Dimens.delayAnimationSignUpPage),
      child: SizedBox(
        width: dimens.Dimens.masterPasswordHintContainerHeightSignUp,
        child: TextFormField(
          controller: signUpController.passwordHints,
          keyboardType: TextInputType.emailAddress,
          cursorColor: colors.AppColor.primaryColor,
          decoration: InputDecoration(
            filled: true, 
            fillColor: colors.AppColor.lightGrey,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(dimens.Dimens.confirmMasterPasswordContainerBorderSignUp),
            ),
            hintText: constants.Constants.masterPasswordHintFieldSignUp,
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: dimens.Dimens.masterPasswordHintFontSizeSignUp,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: dimens.Dimens.masterPasswordHintContentHorizontalPaddingSignUp, 
              vertical: dimens.Dimens.masterPasswordHintContentVerticalPaddingSignUp
            ),
            
            
          ),
          validator: (value){
              if(value!.isEmpty){
              return constants.Constants.masterPasswordHintFieldEmptySignUp;
            }else{
              return null;
            }
            
          },
        )
      )
    );
  }
}