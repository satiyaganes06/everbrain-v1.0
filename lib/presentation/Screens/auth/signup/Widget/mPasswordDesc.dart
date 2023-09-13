import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;

class MasterPasswordDesc extends StatelessWidget {
  const MasterPasswordDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
    delay: Duration(milliseconds: dimens.Dimens.delayAnimationSignUpPage),
    child: Padding(
      padding: EdgeInsets.only(left: dimens.Dimens.masterPasswordDescriptionLeftPaddingSignUp),
      child: Text(
        constants.Constants.masterPasswordDescriptionSignUp,
        style: GoogleFonts.poppins(
          fontSize: dimens.Dimens.masterPasswordFontSizeSignUp,
          color: colors.AppColor.subtitleColor,
          fontWeight: FontWeight.w500
        ),
        textAlign: TextAlign.start,
      )
    )
  );
  }
}