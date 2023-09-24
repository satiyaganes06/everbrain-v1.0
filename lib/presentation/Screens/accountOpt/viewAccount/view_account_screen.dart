import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/presentation/Screens/accountOpt/viewAccount/widget/view_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/keys.dart' as KY;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import '../../../../Model/vault_model.dart';
import '../../../../controller/edit_account_controller.getx.dart';
import '../../../../controller/flutter_encry_controller.getx.dart';
import '../../../../controller/hive_controller.getx.dart';
import '../../../Widget/appbar.dart';
import '../../../Widget/global_widget.dart';
import '../../../Widget/space.dart';
import '../../../Widget/subtitle2_font.dart';
import '../../../Widget/subtitle_font copy.dart';

class ViewVaultScreen extends StatefulWidget {
  final Vault vault;

  const ViewVaultScreen({super.key, required this.vault});

  @override
  State<ViewVaultScreen> createState() => _ViewVaultScreenState();
}

class _ViewVaultScreenState extends State<ViewVaultScreen> {
  final editAccController = Get.put(EditAccountController());
  final hiveController = Get.find<HiveController>();

  @override
  void initState() {
    editAccController.vaultNameCtrl.text = widget.vault.vaultName;
    editAccController.vaultUsernameCtrl.text = widget.vault.username;
    getVaultPass();
    editAccController.vaultWebsiteURLCtrl.text = widget.vault.websiteUrl;
    editAccController.vaultWebsiteImageUrl = widget.vault.websiteImageUrl;
    super.initState();
  }

  getVaultPass() async {
    editAccController.vaultPasswordCtrl.text =
        await hiveController.getVaultPassword(widget.vault.vaultID);
  }

  @override
  build(BuildContext context) {
    const animationDuration = 100;
    Get.lazyPut(() => FlutterEncryController());

    return Scaffold(
      backgroundColor: colors.AppColor.secondaryColor,
      appBar: CommonAppbar(title: '${widget.vault.vaultName} Vault'),
      body: SizedBox(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Space(Get.height * 0.03),
              title('Vault Infomation'),
              Space(Get.height * 0.02),
              DelayedDisplay(
                  delay: Duration(
                      milliseconds: dimens.Dimens.delayAnimationLogInPage),
                  child: viewTextField(
                    textField(editAccController.vaultNameCtrl, 'Name',
                        TextInputType.text, false, true, false, true, image: widget.vault.websiteImageUrl),
                  )),
              Space(Get.height * 0.03),
              DelayedDisplay(
                  delay: Duration(
                      milliseconds: dimens.Dimens.delayAnimationLogInPage),
                  child: viewTextField(textField(
                      editAccController.vaultUsernameCtrl,
                      'Email/Username/Phone',
                      TextInputType.emailAddress,
                      false,
                      true,
                      false,
                      false))),
              Space(Get.height * 0.03),

              DelayedDisplay(
                  delay: Duration(
                      milliseconds: dimens.Dimens.delayAnimationLogInPage),
                  child: viewTextField(textField(
                      editAccController.vaultWebsiteURLCtrl,
                      'URL',
                      TextInputType.text,
                      false,
                      true,
                      false,
                      false))),
              Space(Get.height * 0.03),

              DelayedDisplay(
                  delay: Duration(
                      milliseconds: dimens.Dimens.delayAnimationLogInPage),
                  child: SizedBox(
                    width: dimens.Dimens.emailContainerHeightSignUp,
                    child: GetBuilder<EditAccountController>(
                        builder: (editAccountController) {
                      return TextFormField(
                        controller: editAccountController.vaultPasswordCtrl,
                        keyboardType:
                            editAccountController.getPassViewToggle == false
                                ? TextInputType.visiblePassword
                                : TextInputType.emailAddress,
                        obscureText: editAccountController.getPassViewToggle,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: colors.AppColor.lightGrey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: colors.AppColor.accentColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: dimens.Dimens
                                  .textFieldContentHorizontalPaddingSignUp,
                              vertical: dimens.Dimens
                                  .textFieldContentVerticalPaddingSignUp),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  editAccController.getPassViewToggle == false
                                      ? editAccController.funPasswordViewToggle()
                                      : !widget.vault.isBiometricUnlock ?  _buildShowTextField(context, KY.KYS.optPass) : Get.find<FlutterEncryController>().biometricUnlock(
                                        optValue: KY.KYS.optPass,
                                        title: 'unlock password',
                                        context: context,
                                        vault: widget.vault
                                      );
                                },
                                icon: editAccController.getPassViewToggle == false
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                iconSize: 20,
                                splashRadius: 20,
                                color: editAccController.getPassViewToggle == false
                                    ? Colors.redAccent
                                    : const Color.fromARGB(255, 36, 56, 70),
                              ),
                              IconButton(
                                onPressed: () {
                                  // !widget.vault.isBiometricUnlock ?  _buildShowTextField(context, KY.KYS.optCopy) : Get.find<FlutterEncryController>().biometricUnlock(
                                  //   optValue: KY.KYS.optCopy,
                                  //   title: 'copy password',
                                  //   context: context,
                                  //   vault:widget.vault
                                  // );

                                  editAccController.funPasswordCopy(context);
                                },
                                icon: const Icon(Icons.copy_all_rounded),
                                color: colors.AppColor.tertiaryColor,
                                iconSize: 20,
                                splashRadius: 20,
                              )
                            ]),
                          suffixIconColor: Colors.grey,
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          } else {
                            if (!regex.hasMatch(value)) {
                              return 'Enter valid password';
                            } else {
                              return null;
                            }
                          }
                        },
                      );
                    }),
                  )),
              Space(Get.height * 0.03),
              
              title('Category'),
              Space(Get.height * 0.01),
              DelayedDisplay(
                  delay: const Duration(milliseconds: animationDuration),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: dimens
                              .Dimens.textFieldContentVerticalPaddingSignUp,
                          horizontal: dimens
                              .Dimens.textFieldContentHorizontalPaddingSignUp),
                      decoration: BoxDecoration(
                        color: colors.AppColor.lightGrey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: colors.AppColor.accentColor,
                        ),
                      ),
                      width: dimens.Dimens.emailContainerHeightSignUp,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                child: Text(
                              widget.vault.vaultCategory,
                              style: GoogleFonts.poppins(
                                  color: colors.AppColor.accentColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            )),
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(editAccController
                                      .category_Button_Image_Path[
                                  editAccController.category_Button_Image_title
                                      .indexOf(widget.vault.vaultCategory)]),
                            )
                          ]))),
              Space(Get.height * 0.03),
              title('Advance Setup'),
              Space(Get.height * 0.01),
              DelayedDisplay(
                  delay: const Duration(milliseconds: animationDuration),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Favourite',
                                style: GoogleFonts.poppins(
                                    color: colors.AppColor.accentColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              FlutterSwitch(
                                width: 50,
                                height: 30,
                                activeColor: colors.AppColor.success2,
                                inactiveColor: colors.AppColor.lightGrey,
                                disabled: true,
                                toggleColor: colors.AppColor.secondaryColor,
                                value: widget.vault.isFavourite,
                                onToggle: (val) {},
                              ),
                            ]),
                        Space(Get.height * 0.01),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Use Biometric to unlock ?',
                                style: GoogleFonts.poppins(
                                    color: colors.AppColor.accentColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                                overflow: TextOverflow.fade,
                              ),
                              FlutterSwitch(
                                width: 50,
                                height: 30,
                                activeColor: colors.AppColor.success2,
                                inactiveColor: colors.AppColor.lightGrey,
                                toggleColor: colors.AppColor.secondaryColor,
                                value: widget.vault.isBiometricUnlock,
                                disabled: true,
                                onToggle: (val) {},
                              ),
                            ]),
                      ]))),
              Space(Get.height * 0.05),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          !widget.vault.isBiometricUnlock
              ? _buildShowTextField(context, KY.KYS.optEdit)
              : Get.find<FlutterEncryController>().biometricUnlock(
                  optValue: KY.KYS.optEdit,
                  title: 'edit account',
                  context: context,
                  vault: widget.vault);
        },
        backgroundColor: colors.AppColor.tertiaryColor,
        child: const Icon(Icons.edit),
      ),
    );
  }

  title(String title) {
    return DelayedDisplay(
        delay: const Duration(milliseconds: 100),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SubtitleFont(title.toString()),
          ),
          Space(10)
        ]));
  }

  fieldTitle(String title) {
    return DelayedDisplay(
        delay: const Duration(milliseconds: 100),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Subtitle2Font(title.toString()),
          ),
          Space(10)
        ]));
  }

  _buildShowTextField(BuildContext context, int path) {
    return showTextInputDialog(context: context, textFields: [
      DialogTextField(
        obscureText: true,
        hintText: 'Master Password',
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter correct master password';
          } else {
            Get.find<FlutterEncryController>()
                .validateMasterPass(value, context, path,  vault: widget.vault);
          }
        },
      )
    ]);
  }
}
