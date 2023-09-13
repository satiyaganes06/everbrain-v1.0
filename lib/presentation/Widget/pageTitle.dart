import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;

class PageTitle extends StatelessWidget {
  String title;
  double fontSize;

  PageTitle(this.title, this.fontSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(title,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: colors.AppColor.accentColor,
        letterSpacing: 1
      )
    );
  }
}