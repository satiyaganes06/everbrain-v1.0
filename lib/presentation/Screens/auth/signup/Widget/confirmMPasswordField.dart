import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controller/signup_controller.getx.dart';

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
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 0, color: colors.AppColor.lightGrey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 0, color: colors.AppColor.lightGrey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 0, color: colors.AppColor.lightGrey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "Confirm Master Password",
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: colors.AppColor.subtitle2Color,
                      letterSpacing: 0.3),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal:
                          dimens.Dimens.textFieldContentHorizontalPaddingSignUp,
                      vertical:
                          dimens.Dimens.textFieldContentVerticalPaddingSignUp),
                  
                ),
              validator: (value) {
                
                if (value!.isEmpty) {
                  return constants
                      .Constants.confirmMasterPasswordFieldErrorSignUp2;
                } else if (value !=
                    signUpController.passwordField.text.toString()) {
                  return constants
                      .Constants.confirmMasterPasswordFieldErrorSignUp;
                } else {
                  return null;
                }
              },
            )));
  }
}
