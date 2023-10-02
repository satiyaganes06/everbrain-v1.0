import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/controller/local_auth_controller.getx.dart';
import 'package:everbrain/controller/setting_controller.getx.dart';
import 'package:everbrain/controller/signup_controller.getx.dart';
import 'package:everbrain/presentation/widget/space.dart';
import 'package:everbrain/presentation/widget/subtitle_font%20copy.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import '../../../../controller/flutter_encry_controller.getx.dart';
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:everbrain/utils/keys.dart' as KY;
import '../../../../controller/login_controller.getx.dart';
import '../../../../core/localServices/secure_storage_repository.dart';
import '../../../widget/wide_button.dart';
import '../../masterPasswordReq/master_password_hint_Screen.dart';

class LocalAuthScreen extends StatelessWidget {
  LocalAuthScreen({super.key});

  final flutterEncryCon = Get.put(FlutterEncryController());
  final settingContrl = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    final focusedBorderColor = colors.AppColor.primaryColor;
    final fillColor = colors.AppColor.primaryColor.withOpacity(0.3);
    final borderColor = colors.AppColor.tertiaryColor;

    Get.lazyPut(() => LocalAuthController());

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: colors.AppColor.tertiaryColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Obx(() {
      return Get.find<LocalAuthController>().isLoading.value == false
          ? Scaffold(
              backgroundColor: colors.AppColor.secondaryColor,
              appBar: AppBar(
                  backgroundColor: colors.AppColor.secondaryColor,
                  elevation: 0.1,
                  leading: DelayedDisplay(
                      delay: const Duration(milliseconds: 230),
                      child: Icon(Icons.account_circle_outlined,
                          color: colors.AppColor.tertiaryColor)),
                  title: DelayedDisplay(
                    delay: const Duration(milliseconds: 230),
                    child: GetBuilder<LocalAuthController>(
                        id: 'email_string',
                        builder: (_) {
                          return Text(
                            Get.find<LocalAuthController>().email.toString(),
                            style: GoogleFonts.poppins(
                                color: colors.AppColor.tertiaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          );
                        }),
                  ),
                  actions: [
                    DelayedDisplay(
                        delay: const Duration(milliseconds: 230),
                        child: IconButton(
                          onPressed: () {
                            _showBottomSheet(context);
                          },
                          icon: Icon(Icons.more_vert_outlined,
                              color: colors.AppColor.tertiaryColor),
                        ))
                  ]),
              body: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Space(Get.height * 0.1),

                        Obx(() => Icon(
                              !Get.find<LocalAuthController>().isUnlock.value
                                  ? FluentIcons.lock_closed_32_filled
                                  : FluentIcons.lock_open_32_filled,
                              size: 100,
                              color: colors.AppColor.primaryColor,
                            )),

                        Space(Get.height * 0.05),

                        Obx(() => Get.find<LocalAuthController>().isUnlock.value
                            ? SubtitleFont('everBrain is unlocked')
                            : SubtitleFont('everBrain is locked')),

                        Space(Get.height * 0.05),

                        DelayedDisplay(
                            delay: Duration(
                                milliseconds:
                                    dimens.Dimens.delayAnimationLogInPage),
                            child: Obx(() {
                              if (settingContrl.currentPasscodeOption.value ==
                                  settingContrl.settingOption[1]) {
                                return Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Pinput(
                                    controller: Get.find<LocalAuthController>()
                                        .passcodeController,
                                    focusNode: focusNode,
                                    androidSmsAutofillMethod:
                                        AndroidSmsAutofillMethod
                                            .smsUserConsentApi,
                                    listenForMultipleSmsOnAndroid: true,
                                    defaultPinTheme: defaultPinTheme,
                                    separatorBuilder: (index) =>
                                        const SizedBox(width: 8),
                                    validator: (value) {
                                      return value ==
                                              Get.find<LocalAuthController>()
                                                  .passcode
                                          ? null
                                          : 'Pin is incorrect';
                                    },
                                    hapticFeedbackType:
                                        HapticFeedbackType.mediumImpact,
                                    onCompleted: (pin) {
                                      flutterEncryCon.validatePasscode(pin);
                                    },
                                    obscureText: true,
                                    obscuringWidget: Text(
                                      '●',
                                      style: TextStyle(
                                          color: colors.AppColor.accentColor),
                                    ),
                                    cursor: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 9),
                                          width: 22,
                                          height: 1,
                                          color: focusedBorderColor,
                                        ),
                                      ],
                                    ),
                                    focusedPinTheme: defaultPinTheme.copyWith(
                                      decoration:
                                          defaultPinTheme.decoration!.copyWith(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: focusedBorderColor),
                                      ),
                                    ),
                                    submittedPinTheme: defaultPinTheme.copyWith(
                                      decoration:
                                          defaultPinTheme.decoration!.copyWith(
                                        color: fillColor,
                                        borderRadius: BorderRadius.circular(19),
                                        border: Border.all(
                                            color: focusedBorderColor),
                                      ),
                                    ),
                                    errorPinTheme:
                                        defaultPinTheme.copyBorderWith(
                                      border:
                                          Border.all(color: Colors.redAccent),
                                    ),
                                  ),
                                );
                              } else if (settingContrl
                                      .currentPasscodeOption.value ==
                                  settingContrl.settingOption[0]) {
                                return GetBuilder<LoginController>(
                                    dispose: (state) {
                                  state.controller?.password_field.clear();
                                }, builder: (loginController) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(children: [
                                      SizedBox(
                                        width: dimens.Dimens
                                            .masterPasswordContainerHeightLogIn,
                                        child: TextFormField(
                                          controller:
                                              loginController.password_field,
                                          keyboardType: loginController
                                                      .passwordToggle ==
                                                  false
                                              ? TextInputType.visiblePassword
                                              : TextInputType.emailAddress,
                                          obscureText:
                                              loginController.passwordToggle,
                                          cursorColor:
                                              colors.AppColor.primaryColor,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                colors.AppColor.lightGrey,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  color: colors
                                                      .AppColor.lightGrey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  color: colors
                                                      .AppColor.lightGrey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  color: colors
                                                      .AppColor.lightGrey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            labelText: 'Master Password',
                                            labelStyle: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: colors
                                                    .AppColor.subtitle2Color,
                                                letterSpacing: 0.5),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: dimens.Dimens
                                                    .textFieldContentHorizontalPaddingSignUp,
                                                vertical: dimens.Dimens
                                                    .textFieldContentVerticalPaddingSignUp),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                loginController
                                                    .funPasswordToggle();
                                              },
                                              icon: loginController
                                                          .passwordToggle ==
                                                      false
                                                  ? const Icon(Icons
                                                      .visibility_off_outlined)
                                                  : const Icon(Icons
                                                      .visibility_outlined),
                                              iconSize: dimens.Dimens
                                                  .masterPasswordIconSize,
                                              splashRadius: dimens.Dimens
                                                  .masterPasswordIconSplashRadius,
                                              color: loginController
                                                          .passwordToggle ==
                                                      false
                                                  ? colors.AppColor.fail
                                                  : colors.AppColor.success,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return constants.Constants
                                                  .masterPasswordFieldEmptyLogIn;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      Space(Get.height * 0.05),
                                      WideButton('Unlock', () {
                                        flutterEncryCon.validateMasterPass(
                                            loginController.password_field.text,
                                            context,
                                            KY.KYS.optUnlock);
                                      }),
                                    ]),
                                  );
                                });
                              } else {
                                return const SizedBox();
                              }
                            })),

                        // Space(Get.height * 0.02),

                        // DelayedDisplay(
                        //   delay: Duration(
                        //       milliseconds: dimens.Dimens.delayAnimationLogInPage),
                        //       child: Padding(
                        //         padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                        //         child: Row(
                        //           children: [
                        //             const Expanded(child: SizedBox()),

                        //             GestureDetector(
                        //               onTap: () {

                        //               },
                        //               child: Text(
                        //                 'Forgot Pin?',
                        //                 style: GoogleFonts.poppins(
                        //                     color: colors.AppColor.tertiaryColor,
                        //                     fontWeight: FontWeight.w500,
                        //                     fontSize: 12),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        // ),

                        Space(Get.height * 0.05),

                        DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  dimens.Dimens.delayAnimationLogInPage),
                          child: Obx(() {
                            return settingContrl.currentBiometricOption.value ==
                                    settingContrl.settingOption[1]
                                ? GestureDetector(
                                    onTap: () {
                                      flutterEncryCon.biometricUnlock(
                                          optValue: KY.KYS.optUnlock,
                                          title: 'unlock',
                                          context: context);
                                    },
                                    child: Container(
                                      height: Get.height * 0.06,
                                      width: Get.height * 0.06,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: colors.AppColor.primaryColor,
                                      ),
                                      child: Icon(
                                        Iconsax.finger_scan,
                                        color: colors.AppColor.secondaryColor,
                                      ),
                                    ))
                                : const SizedBox();
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: Get.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colors.AppColor.lightGrey,
                      ),
                      child: Lottie.asset(
                        'assets/lottie/splash_screen_Animation.json',
                        height: Get.height * 0.2,
                        width: Get.width * 0.2,
                      )),
                  Space(Get.height * 0.02),
                  SubtitleFont('Authenticating...'),
                ],
              ),
            ));
    });
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
                title: Obx(() => Text(
                      settingContrl.currentPasscodeOption.value ==
                              settingContrl.settingOption[0]
                          ? 'Get Master Password Hints'
                          : 'Forgot Passcode?',
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )),
                onTap: () {
                  if (settingContrl.currentPasscodeOption.value ==
                      settingContrl.settingOption[0]) {
                    Navigator.pop(context);
                    Get.to(() => PasswordHintScreen());
                  } else if (settingContrl.currentPasscodeOption.value ==
                      settingContrl.settingOption[1]) {
                    Navigator.pop(context);
                    settingContrl.currentPasscodeOption.value =
                        settingContrl.settingOption[0];
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.lock,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                    color: colors.AppColor.tertiaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  Get.find<SettingController>().signOutFun(context);
                },
              ),
            ],
          );
        });
  }
}
