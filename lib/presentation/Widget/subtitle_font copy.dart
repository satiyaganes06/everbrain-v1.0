import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;

class SubtitleFont extends StatelessWidget {
  
  String title;

  SubtitleFont(this.title);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(title.toString(), style: GoogleFonts.poppins(
      color: colors.AppColor.accentColor,
      fontWeight: FontWeight.bold,
      fontSize: 16
    ),);
  }
}