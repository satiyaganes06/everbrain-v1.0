import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class AddAccountAppBar {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: GetPlatform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios_new),
        onPressed: (){
          Get.back();
        },
        color: colors.AppColor.secondaryColor,
        splashRadius: 20,
      ),
      backgroundColor: colors.AppColor.primaryColor,
      elevation: 0.5,
      title: Text('constants.Constants.addAccountTitle', 
          style: GoogleFonts.poppins(
          color: colors.AppColor.secondaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 16
        ),
      ),
      centerTitle: true,
    );
  }
}