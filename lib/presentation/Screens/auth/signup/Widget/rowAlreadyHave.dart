
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RowAlreadyHave extends StatelessWidget {
  const RowAlreadyHave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: dimens.Dimens.delayAnimationSignUpPage),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(constants.Constants.signInDescButtonSignUp,
            style: GoogleFonts.poppins(
              fontSize: dimens.Dimens.alreadyHaveFontSizeSignUp,
              fontWeight: FontWeight.w600
            ),
          ),
          TextButton(
            onPressed: (){
              Get.back();
            }, 
            child: Text(constants.Constants.signInTitleButtonSignUp,
              style: GoogleFonts.poppins(
                color: colors.AppColor.primaryColor,
                fontSize: dimens.Dimens.alreadyHaveFontSizeSignUp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      )
    );
  }
}