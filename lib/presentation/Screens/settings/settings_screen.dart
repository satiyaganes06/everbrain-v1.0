import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:everbrain/controller/setting_controller.getx.dart';
import 'package:everbrain/presentation/Widget/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconsax/iconsax.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import '../../../controller/login_controller.getx.dart';
import '../../Widget/appbar.dart';
import '../../Widget/subtitle_font copy.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    
    return Scaffold(
        appBar: CommonAppbar(title: "Settings"),
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
                trailing: GetBuilder<SettingController>(
                  id: 'biometric',
                  builder: (_) {
                    return Text(settingController.currentBiometricOption,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: settingController.currentBiometricOption == 'off' ? colors.AppColor.subtitleColor : colors.AppColor.success));
                  }
                ),
                onTap: () {
                  _showBottomSheet(context, settingController);
                },
              ),

              ListTile(
                leading: Icon(
                  Iconsax.finger_scan,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("Unlock with Passcode",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                trailing: GetBuilder<SettingController>(
                  id: 'biometric',
                  builder: (_) {
                    return Text(settingController.currentBiometricOption,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: settingController.currentBiometricOption == 'off' ? colors.AppColor.subtitleColor : colors.AppColor.success));
                  }
                ),
                onTap: () {
                  _showBottomSheet(context, settingController);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: const Text("Lock now"),
                onTap: () {
                  Navigator.pop(context);
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
                title: Row(children: [
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
                  Navigator.pop(context);
                },
              ),

              Space(Get.height * 0.02),

              SubtitleFont('Other'),

              Space(Get.height * 0.02),
              
              ListTile(
                leading: Icon(
                  Iconsax.people,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text("About Us",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.AppColor.tertiaryColor)),
                onTap: () {
                  Navigator.pop(context);
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
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  size: 20,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: const Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  final loginContrl = Get.find<LoginController>();

                  loginContrl.firebaseService.signOut();
                },
              ),
              Space(Get.height * 0.05),
            ]));
  }

  _showBottomSheet(BuildContext context, SettingController settingController) {
    return showModalActionSheet(
        context: context,
        title: 'Menu',
        builder: (context, _) {
          return GetBuilder<SettingController>(
            id: 'biometric',
            builder: (_) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile(
                    selected: true,
                    selectedTileColor: colors.AppColor.lightGrey,
                    title: Text(
                      'off',
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    groupValue: settingController.currentBiometricOption,
                    onChanged: (value) {
                      settingController.setBiometricOption(value!, context);
                    },
                    value: settingController.settingOption[0],
                  ),

                  RadioListTile(
                    selected: true,
                    selectedTileColor: colors.AppColor.lightGrey,
                    title: Text(
                      'on',
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    groupValue: settingController.currentBiometricOption,
                    onChanged: (value) {
                      settingController.setBiometricOption(value!, context);
                    },
                    value: settingController.settingOption[1],
                  ),
                ],
              );
            }
          );
        });
  }
}
