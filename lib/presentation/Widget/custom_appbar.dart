
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import '../../Controller/login_controller.dart';
import '../Screens/master_password_hint_Screen.dart';

class CustomAppBar extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      leading: Container(
        color:colors.AppColor.primaryColor
      ),
      // leading: GestureDetector(
      //   onTap:(){
      //     //navigatorController.handleMenuButtonPressed();
      //   },
      //   child: AvatarGlow(
      //     shape: BoxShape.circle,
      //     glowColor: colors.AppColor.tertiaryColor,
      //     endRadius: 25,
      //     child: OctoImage(
      //       image: const CachedNetworkImageProvider('https://thumbs.dreamstime.com/b/sg-logo-letter-monogram-slash-modern-designs-template-black-color-white-background-164908221.jpg'),
      //       errorBuilder: OctoError.icon(color: colors.AppColor.accentColor),
      //       fit: BoxFit.cover,
      //       imageBuilder: OctoImageTransformer.circleAvatar(),
      //       height: 30,
      //       progressIndicatorBuilder: (context, progress) {
      //         return const Loading();
      //       },
      //     )
      //   ),
      // ),
      title: Text(
        'Everbrain',
        style: GoogleFonts.poppins(
            color: colors.AppColor.secondaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1),
      ),
      centerTitle: true,
      backgroundColor: colors.AppColor.primaryColor,
      elevation: 1,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          iconSize: 25,
          splashRadius: 20,
          color: colors.AppColor.secondaryColor,
          onPressed: () {
            //
            _showBottomSheet(context);
          },
        )
      ],
    );
  }

  _showBottomSheet(BuildContext context) {
    return showModalActionSheet(
        context: context,
        title: 'Menu',
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text(
                  'Get Master Password Hints',
                  style: GoogleFonts.poppins(
                      color: colors.AppColor.tertiaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(PasswordHintScreen());
                  
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: colors.AppColor.fail,
                ),
                title: Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                      color: colors.AppColor.tertiaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,),
                ),
                onTap: () {
                  Navigator.pop(context);
                  loginController.firebaseService.signOut();
                },
              ),
            ],
          );
        });
  }

  
}