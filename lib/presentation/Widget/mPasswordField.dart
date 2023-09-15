
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/login_controller.getx.dart';

class MasterPasswordFieldLogin extends StatelessWidget {
  MasterPasswordFieldLogin({Key? key}) : super(key: key);
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds:dimens.Dimens.delayAnimationLogInPage),
      child: SizedBox(
        width: dimens.Dimens.masterPasswordContainerHeightLogIn,
        child: GetBuilder<LoginController>(builder: (_){
            return TextFormField(
              controller: loginController.password_field,
              keyboardType: loginController.passwordToggle == false?
                TextInputType.visiblePassword : TextInputType.emailAddress,
              obscureText: loginController.passwordToggle,
              cursorColor: colors.AppColor.primaryColor,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true, 
                fillColor: colors.AppColor.lightGrey,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0, color: colors.AppColor.lightGrey), 
                  borderRadius: BorderRadius.circular(dimens.Dimens.masterPasswordContainerBorderLogIn),
                ),
                hintText: constants.Constants.masterPasswordFieldLogIn,
                hintStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: dimens.Dimens.masterPasswordFontSizeLogIn,
                ),
                contentPadding: EdgeInsets.only(left: dimens.Dimens.masterPasswordContentLeftPaddingLogIn),
                suffixIcon: IconButton(
                  onPressed: (){
                    loginController.funPasswordToggle();
                  },
                  icon: loginController.passwordToggle== false ?
                  const Icon(Icons.visibility_off_outlined) :
                  const Icon(Icons.visibility_outlined),
                  iconSize: dimens.Dimens.masterPasswordIconSize,
                  splashRadius: dimens.Dimens.masterPasswordIconSplashRadius,
                  color: loginController.passwordToggle == false ?
                  colors.AppColor.fail :
                  colors.AppColor.success,
                ),
              ),
              validator: (value) {
                RegExp regex =
                RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,12}$');
                  if (value!.isEmpty) {
                  return constants.Constants.masterPasswordFieldEmptyLogIn;
                } else {
                  if (!regex.hasMatch(value)) {
                    return constants.Constants.masterPasswordFieldErrorLogIn;
                  } else {
                    return null;
                  }
                }
              },
              
          );
        }),
      )
    );
  }
}