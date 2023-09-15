
import 'package:delayed_display/delayed_display.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controller/signup_controller.getx.dart';

class MasterPasswordSignUp extends StatelessWidget {
  MasterPasswordSignUp({Key? key}) : super(key: key);

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds:dimens.Dimens.delayAnimationSignUpPage),
      child: SizedBox(
          width: dimens.Dimens.masterPasswordContainerHeightSignUp,
          child: GetBuilder<SignUpController>(builder: (_){
              return FancyPasswordField(
                keyboardType: signUpController.passwordToggle == false?
                  TextInputType.visiblePassword : TextInputType.emailAddress,
                obscureText: signUpController.passwordToggle,
                cursorColor: colors.AppColor.primaryColor,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true, 
                  fillColor: colors.AppColor.lightGrey,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0, color: colors.AppColor.lightGrey), 
                    borderRadius: BorderRadius.circular(dimens.Dimens.masterPasswordContainerBorderSignUp),
                  ),
                  hintText: constants.Constants.masterPasswordFieldSignUp,
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: dimens.Dimens.masterPasswordFontSizeSignUp,
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      signUpController.funPasswordToggle();
                    },
                    icon: signUpController.passwordToggle== false ?
                    const Icon(Icons.visibility_off_outlined) :
                    const Icon(Icons.visibility_outlined),
                    iconSize: dimens.Dimens.masterPasswordIconSize,
                    splashRadius: dimens.Dimens.masterPasswordIconSplashRadius,
                    color: signUpController.passwordToggle == false ?
                    colors.AppColor.fail :
                    colors.AppColor.success,
                  ),
                  
                  contentPadding: EdgeInsets.only(left: dimens.Dimens.masterPasswordContentLeftPaddingSignUp)
                ),
                hasShowHidePassword : false,
                hasStrengthIndicator: false,
                controller: signUpController.passwordField,
                validationRules: {
                    DigitValidationRule(),
                    UppercaseValidationRule(),
                    LowercaseValidationRule(),
                    SpecialCharacterValidationRule(),
                    MinCharactersValidationRule(6),
                    MaxCharactersValidationRule(12),
                },
                validationRuleBuilder: (rules, value) {
                  if (value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 2.0,
                        runSpacing: 5,
                        children: rules
                            .map(
                              (rule) => rule.validate(value)
                                  ? Container(
                                    height: 20,
                                    width: rule.name == 'Has digit' ? 60: 120,
                                    decoration: BoxDecoration(
                                      color: colors.AppColor.success,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: 
                                        Center(
                                          child: Text(
                                              rule.name,
                                              style: TextStyle(
                                                  color: colors.AppColor.secondaryColor,
                                                  fontSize: 11,
                                              ),
                                          )
                                        ),
                                    )
                                  : Container(
                                    height: 20,
                                    width: rule.name == 'Has digit' ? 60: 120,
                                    decoration: BoxDecoration(
                                      color: colors.AppColor.fail,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: 
                                        Center(
                                          child: Text(
                                              rule.name,
                                              style: TextStyle(
                                                  color: colors.AppColor.secondaryColor,
                                                  fontSize: 11,
                                              ),
                                          ),
                                        ),
                                    )
                            )
                            .toList(),
                      
                    )
                  );
                },
                validator: (value) {
                  RegExp regex =
                  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,12}$');

                  if (value!.isEmpty) {
                    return constants.Constants.masterPasswordFieldEmptySignUp;
                  } else {
                    if (!regex.hasMatch(value)) {
                      return constants.Constants.masterPasswordFieldErrorSignUp;
                    } else {
                      return null;
                    }
                  }
                }
              );
            
          }),
        )
    );
  }

  

            //         TextFormField(
                
            //     controller: signUpController.passwordField,
            //     keyboardType: signUpController.passwordToggle == false?
            //       TextInputType.visiblePassword : TextInputType.emailAddress,
            //     obscureText: signUpController.passwordToggle,
            //     cursorColor: colors.AppColor.primaryColor,
            //     textAlignVertical: TextAlignVertical.center,
            //     decoration: InputDecoration(
            //       hintText: constants.Constants.masterPasswordFieldSignUp,
            //       hintStyle: GoogleFonts.poppins(
            //         fontWeight: FontWeight.w500,
            //         fontSize: dimens.Dimens.masterPasswordFontSizeSignUp,
            //       ),
            //       contentPadding: EdgeInsets.only(left: dimens.Dimens.masterPasswordContentLeftPaddingSignUp),
            //       border: InputBorder.none,
            //       suffixIcon: IconButton(
            //         onPressed: (){
            //           signUpController.funPasswordToggle();
            //         },
            //         icon: signUpController.passwordToggle== false ?
            //         const Icon(Icons.visibility_off_outlined) :
            //         const Icon(Icons.visibility_outlined),
            //         iconSize: dimens.Dimens.masterPasswordIconSize,
            //         splashRadius: dimens.Dimens.masterPasswordIconSplashRadius,
            //         color: signUpController.passwordToggle == false ?
            //         colors.AppColor.fail :
            //         colors.AppColor.success,
            //       ),
            //       suffixIconColor: Colors.grey,
            //     ),
            //     validator: (value) {
            //       RegExp regex =
            //       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

            //       if (value!.isEmpty) {
            //         return constants.Constants.masterPasswordFieldEmptySignUp;
            //       } else {
            //         if (!regex.hasMatch(value)) {
            //           return constants.Constants.masterPasswordFieldErrorSignUp;
            //         } else {
            //           return null;
            //         }
            //       }
            //     },
                
            // );
}