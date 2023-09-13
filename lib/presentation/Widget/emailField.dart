import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/login_controller.dart';

class EmailFieldLogin extends StatelessWidget {
  EmailFieldLogin({Key? key}) : super(key: key);
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds:dimens.Dimens.delayAnimationLogInPage),
      child: SizedBox(
        width: dimens.Dimens.emailContainerHeightLogIn,
        
        child: TextFormField(
          controller: loginController.email_field,
          keyboardType: TextInputType.emailAddress,
          cursorColor: colors.AppColor.primaryColor,
          decoration:  InputDecoration(
            filled: true, 
            fillColor: colors.AppColor.lightGrey,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(dimens.Dimens.emailContainerBorderLogIn),
            ),
            hintText: constants.Constants.emailFieldLogIn,
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: dimens.Dimens.emailFontSizeLogIn,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: dimens.Dimens.emailContentHorizontalPaddingLogIn, vertical: dimens.Dimens.emailContentVerticalPaddingLogIn),
            
          ),
          validator: (value){
              if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
              return constants.Constants.emailFieldErrorLogIn;
            }else{
              return null;
            }
            
          },
        )
      )
    );
  }
}