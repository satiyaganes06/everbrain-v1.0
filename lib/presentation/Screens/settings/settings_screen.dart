import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:everbrain/controller/setting_controller.getx.dart';
import 'package:everbrain/presentation/Screens/auth/local_auth/local_auth_screen.dart';
import 'package:everbrain/presentation/Screens/securityQuestion/security_screen.dart';
import 'package:everbrain/presentation/widget/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:lottie/lottie.dart';
import '../../../controller/login_controller.getx.dart';
import '../../widget/appbar.dart';
import '../../widget/subtitle_font copy.dart';
import '../masterPasswordReq/master_password_hint_Screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.find<SettingController>();

    return Scaffold(
        appBar: CommonAppbar(title: "Settings", isBackBtnEnable: false,),
        body: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            children: [

              Space(Get.height * 0.02),

              SubtitleFont('Security'),

              Space(Get.height * 0.02),

              ListTile(
                enabled: false,
                leading: Icon(
                  Icons.timer_outlined,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Row(children: [
                  Text("App time out",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.AppColor.tertiaryColor)),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                        color: colors.AppColor.fail,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("Coming Soon",
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: colors.AppColor.secondaryColor)),
                  )
                ]),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Iconsax.finger_scan,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("Unlock with Biometrics",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                trailing: Obx(() => Text(
                    settingController.currentBiometricOption.value,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: settingController.currentBiometricOption.value ==
                                settingController.settingOption[0]
                            ? colors.AppColor.subtitleColor
                            : colors.AppColor.success))),
                onTap: () {
                  _showBottomSheetBiometric(context, settingController);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.pin_outlined,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("Unlock with Passcode",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                trailing: Obx(() => Text(
                    settingController.currentPasscodeOption.value,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: settingController.currentPasscodeOption.value ==
                                settingController.settingOption[0]
                            ? colors.AppColor.subtitleColor
                            : colors.AppColor.success))),
                onTap: () {
                  settingController.currentPasscodeOption.value ==
                          settingController.settingOption[0]
                      ? _showBottomSheetPasscode(context, settingController)
                      : settingController.setPasscodeOption('', 'off', context);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.hive_outlined,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("Get Master Password Hints",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                
                onTap: () {
                  Get.to(()=> PasswordHintScreen());
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.security_outlined,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("Security Questions",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                
                onTap: () {
                  Get.to(()=> SecurityQuestionScreen());
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("Lock now", style:  GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                onTap: () {
                  Get.offAll(LocalAuthScreen());
                },
              ),

              Space(Get.height * 0.02),

              SubtitleFont('Backup'),

              Space(Get.height * 0.02),

              ListTile(
                enabled: false,
                leading: Icon(
                  Iconsax.export,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Row(
                  children: [

                  Text("Export Vault",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.AppColor.tertiaryColor)),

                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                        color: colors.AppColor.fail,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("Coming Soon",
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: colors.AppColor.secondaryColor)),
                  )
                ]),

                onTap: () {

                },
              ),

              Space(Get.height * 0.02),

              SubtitleFont('Other'),

              Space(Get.height * 0.02),

              ListTile(
                enabled: false,
                leading: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: colors.AppColor.premiumColor
                  ),
                  child: Icon(Icons.diamond_outlined, size: 20, color: colors.AppColor.secondaryColor,)
                  //Lottie.asset('assets/lottie/premium_crown.json', fit: BoxFit.cover,),
                ),  
                //Icon(Icons.diamond_rounded, size: 20, color: colors.AppColor.premiumColor),
                title: Row(
                  children: [
                    Text("Go Premium",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: colors.AppColor.tertiaryColor)),
                    

                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          color: colors.AppColor.fail,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text("Coming Soon",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colors.AppColor.secondaryColor)),
                    )
                  ]
                ),
                onTap: () {
                  //_showDialogBar(context, 'About', 'Everbrain v1.0.0');
                },
              ),

              ListTile(
                leading: Icon(
                  Iconsax.people,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("About",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                onTap: () {
                  _showDialogBar(context, 'About', 'Everbrain v1.0.0');
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.contact_support_outlined,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("Contact Us",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                onTap: () {
                  settingController.contactEmailFun();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  size: 20,
                  color: colors.AppColor.fail,
                ),
                title:  Text("Logout", style:  GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.fail)),
                onTap: () {
                  
                  settingController.signOutFun(context);
                },
              ),
              Space(Get.height * 0.05),
            ]));
  }

  _showBottomSheetBiometric(
      BuildContext context, SettingController settingController) {
    return showModalActionSheet(
        context: context,
        builder: (context, _) {
          return Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile(
                    selected: true,
                    selectedTileColor: colors.AppColor.lightGrey,
                    title: Text(
                      settingController.settingOption[0],
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    groupValue: settingController.currentBiometricOption.value,
                    onChanged: (value) {
                      settingController.setBiometricOption(value!, context);
                    },
                    value: settingController.settingOption[0],
                  ),
                  RadioListTile(
                    selected: true,
                    selectedTileColor: colors.AppColor.lightGrey,
                    title: Text(
                      settingController.settingOption[1],
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    groupValue: settingController.currentBiometricOption.value,
                    onChanged: (value) {
                      settingController.setBiometricOption(value!, context);
                    },
                    value: settingController.settingOption[1],
                  ),
                ],
              ));
        });
  }

  _showBottomSheetPasscode(
      BuildContext context, SettingController settingController) {
    return showTextInputDialog(
        context: context,
        title: 'Enter Passcode',
        message:
            'Set your passcode for unlock Everbrain. Your passcode settings will be reset if you logout from your account.',
        textFields: [
          DialogTextField(
            keyboardType: TextInputType.number,
            obscureText: true,
            hintText: 'Passcode',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter passcode';
              } else if (value!.length != 4) {
                return 'Please enter 4 digit passcode';
              } else {
                settingController.setPasscodeOption(
                    value!, settingController.settingOption[1], context);
              }
            },
          )
        ]);
  }

  _showDialogBar(BuildContext context, String title, String message) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(
                message,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            ));
  }
}
