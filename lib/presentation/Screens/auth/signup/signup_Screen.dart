// ignore_for_file: sort_child_properties_last
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/controller/login_controller.getx.dart';
import 'package:everbrain/presentation/widget/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../widget/pageTitle.dart';
import '../../../widget/space.dart';
import 'Widget/agreeStatementToggle.dart';
import 'Widget/confirmMPasswordField.dart';
import 'Widget/emailField.dart';
import 'Widget/mPasswordDesc.dart';
import 'Widget/mPasswordField.dart';
import 'Widget/mPasswordHint.dart';
import 'Widget/rowAlreadyHave.dart';
import 'Widget/signInButton.dart';
import '../../../../controller/signup_controller.getx.dart';


class SignUpScreen extends StatelessWidget {
  final formkey= GlobalKey<FormState>();
  final signUpController = Get.put(SignUpController());
  final loginController = Get.find<LoginController>();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return KeyboardDismisser(
      gestures: const [
        GestureType.onDoubleTap,
        GestureType.onVerticalDragDown
      ],
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colors.AppColor.secondaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(dimens.Dimens.overallPagePaddingSignUp),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  DelayedDisplay(
                    delay: Duration(milliseconds:dimens.Dimens.delayAnimationSignUpPage),
                    child: PageTitle(
                      constants.Constants.signUpTitle, 
                      dimens.Dimens.titleSignUp
                    ),
                  ),
                  
                  Space(dimens.Dimens.bottomTitleSpaceSignUp),
                  
                  //EmailFieldSignUp(),

                  DelayedDisplay(
                    delay: Duration(milliseconds:dimens.Dimens.delayAnimationSignUpPage),
                    child: textField(signUpController.emailField, 'Email', TextInputType.emailAddress, false, false, false, false),
                  ),
                  
                  Space(dimens.Dimens.bottomEmailFieldSpaceSignUp),
                  
                  MasterPasswordSignUp(),

                  Space(dimens.Dimens.bottomMasterPasswordFieldSpaceSignUp),//
                  
                  const MasterPasswordDesc(),
                  
                  Space(dimens.Dimens.bottomMasterPasswordDescriptionFieldSpaceSignUp),
                  
                  ConfirmMasterPasswordField(),
                  
                  Space(dimens.Dimens.bottomConfirmMasterPasswordDescriptionFieldSpaceSignUp),
                  
                  //MasterPasswordHint(),
                  DelayedDisplay(
                    delay: Duration(milliseconds:dimens.Dimens.delayAnimationSignUpPage),
                    child: textField(signUpController.passwordHints, 'Master Password Hints', TextInputType.text, false, false, false, false),
                  ),
                  
                  Space(dimens.Dimens.bottomMasterPasswordHintSpaceSignUp),
                  
                  SignInButton(formkey),
                  
                  Space(dimens.Dimens.bottomSignUpButtonSpaceSignUp),
                  
                  AgreementStatementToggle(),
                  
                  Space(dimens.Dimens.bottomAgreeToggleSpaceSignUp),
                  
                  const RowAlreadyHave()
                ],
              )
            )
          )
        )
      )
    );
  }

}