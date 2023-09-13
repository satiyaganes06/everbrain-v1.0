import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/Controller/signup_controller.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailFieldSignUp extends StatelessWidget {
  EmailFieldSignUp({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
      return DelayedDisplay(
      delay: Duration(milliseconds:dimens.Dimens.delayAnimationSignUpPage),
      child: SizedBox(
        width: dimens.Dimens.emailContainerHeightSignUp,
        child: TextFormField(
          controller: signUpController.emailField,
          keyboardType: TextInputType.emailAddress,
          cursorColor: colors.AppColor.primaryColor,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true, 
            fillColor: colors.AppColor.lightGrey,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: constants.Constants.emailFieldSignUp,
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: dimens.Dimens.emailFontSizeSignUp,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: dimens.Dimens.emailContentHorizontalPaddingSignUp, vertical: dimens.Dimens.emailContentVerticalPaddingSignUp),
            
          ),
          validator: (value){

            if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
              return constants.Constants.emailFieldErrorSignUp;
            }else{
              return null;
            }
            
          },
        )
      )
    );
  }
}