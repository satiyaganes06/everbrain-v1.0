import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  const LottieAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
    delay: Duration(milliseconds:dimens.Dimens.delayAnimationLogInPage),
    child: Center(
      child: Lottie.asset(
        'assets/lottie/login_page_animation.json',
        height: dimens.Dimens.lottieAnimationHightLogIn
      )
    ));
  }
}