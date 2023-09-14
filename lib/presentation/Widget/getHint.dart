import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/masterPasswordReq/master_password_hint_Screen.dart';

class GetHintLogin extends StatelessWidget {
  const GetHintLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [ 
        const Expanded(child: Text('')),
          DelayedDisplay(
          delay: Duration(milliseconds:dimens.Dimens.delayAnimationLogInPage),
          child: TextButton(
            onPressed: (){
              Get.to(()=> PasswordHintScreen());
            }, 
            child: Text(constants.Constants.masterPasswordHint,
              style: GoogleFonts.poppins(
                color: colors.AppColor.subtitleColor,
                fontSize: dimens.Dimens.getMasterPasswordHintFontSizeeLogIn,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        )
      ],
    );
  }
}