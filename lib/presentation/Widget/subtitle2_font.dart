import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;

class Subtitle2Font extends StatelessWidget {
  
  final title;

  const Subtitle2Font(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(title.toString(), style: GoogleFonts.poppins(
      color: colors.AppColor.accentColor,
      fontWeight: FontWeight.w500,
      fontSize: 14
    ),);
  }
}