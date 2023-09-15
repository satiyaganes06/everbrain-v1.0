// ignore_for_file: sort_child_properties_last
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/presentation/Widget/pageTitle.dart';
import 'package:everbrain/presentation/Widget/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../../controller/login_controller.getx.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;

import '../../../Widget/emailField.dart';
import '../../../Widget/getHint.dart';
import '../../../Widget/loginButton.dart';
import '../../../Widget/lottieAnimation.dart';
import '../../../Widget/mPasswordField.dart';
import '../../../Widget/rowNotMember.dart';

class LoginScreen extends StatelessWidget {
  final formkey= GlobalKey<FormState>();
  final loginController = Get.find<LoginController>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return KeyboardDismisser(
      gestures: const [
        GestureType.onDoubleTap,
        GestureType.onVerticalDragDown
      ],
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: colors.AppColor.secondaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(dimens.Dimens.overallPagePaddingLogIn),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  DelayedDisplay(
                    delay: Duration(milliseconds:dimens.Dimens.delayAnimationLogInPage),
                    child: PageTitle(constants.Constants.logInTitle, dimens.Dimens.titleLogIn)
                  ),
                  
                  Space(dimens.Dimens.bottomTitleSpaceLogIn),

                  const LottieAnimation(),
                  
                  Space(dimens.Dimens.bottomLottieSpaceLogIn),
                  
                  EmailFieldLogin(),
                  
                  Space(dimens.Dimens.bottomEmailFieldSpaceLogIn),
                  
                  MasterPasswordFieldLogin(),
                  
                  const GetHintLogin(),
                  
                  Space(dimens.Dimens.bottomGetMasterPasswordHintFieldSpaceLogIn),
                  
                  LoginButton(formkey),
                  
                  Space(dimens.Dimens.bottomSubmitButtomSpaceLogIn),
                  
                  const RowNotMember()
                ],
              )
            )
          )
        )
      )
    );
  }

}