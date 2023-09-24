// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget{
  String title;
  bool isActionBtnEnable = false;
  bool isBackBtnEnable = true;
  Icon? icon;
  Function? actionBtnFunction = () {};

  CommonAppbar({
    Key? key,
    required this.title,
    this.isActionBtnEnable = false,
    this.icon,
    this.actionBtnFunction,
    this.isBackBtnEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: isBackBtnEnable ? IconButton(
          icon: GetPlatform.isAndroid
              ? const Icon(Icons.arrow_back)
              : const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
          color: colors.AppColor.secondaryColor,
          splashRadius: 20,
        ) : null,
        backgroundColor: colors.AppColor.primaryColor,
        elevation: 0.5,
        title: Text(
          title,
          style: GoogleFonts.poppins(
              color: colors.AppColor.secondaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          if (isActionBtnEnable)
            IconButton(
              icon: icon!,
              iconSize: 25,
              splashRadius: 20,
              color: colors.AppColor.secondaryColor,
              onPressed: () {
                actionBtnFunction!();
              },
            )
        ],
      );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
