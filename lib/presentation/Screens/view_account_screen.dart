import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/core/path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import '../../Controller/add_new_account_controller.dart';
import '../../Controller/edit_account_controller.dart';
import '../../Controller/flutter_encry_controller.dart';
import '../../Model/vault_model.dart';
import '../../presentation/Widget/space.dart';
import '../../presentation/Widget/subtitle2_font.dart';
import '../../presentation/Widget/subtitle_font copy.dart';
import 'edit_account_screen.dart';

class ViewVaultScreen extends StatefulWidget {
  final vault;

  const ViewVaultScreen({super.key, required this.vault});

  @override
  State<ViewVaultScreen> createState() => _ViewVaultScreenState();
}

class _ViewVaultScreenState extends State<ViewVaultScreen> {
  final editAccController = Get.put(EditAccountController());
  final encryController = Get.find<FlutterEncryController>();
  final path = Paths();
  
  @override
  Widget build(BuildContext context) {
    const animationDuration = 100;

    return Scaffold(
      backgroundColor: colors.AppColor.secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: GetPlatform.isAndroid
              ? const Icon(Icons.arrow_back)
              : const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
          color: colors.AppColor.secondaryColor,
          splashRadius: 20,
        ),
        backgroundColor: colors.AppColor.primaryColor,
        elevation: 0.5,
        title: Text(
          constants.Constants.viewAccountTitle,
          style: GoogleFonts.poppins(
              color: colors.AppColor.secondaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Container(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Space(Get.height * 0.03),

              titleWidget('Account Infomation'),

              Space(Get.height * 0.02),

              fieldTitle('Name'),

              DelayedDisplay(
                  delay: const Duration(milliseconds: animationDuration),
                  child: SizedBox(
                      width: dimens.Dimens.emailContainerHeightSignUp,
                      child: TextFormField(
                        initialValue: widget.vault.sourceName,
                        readOnly: true,
                        keyboardType: TextInputType.name,
                        cursorColor: colors.AppColor.primaryColor,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: colors.AppColor.lightGrey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0, color: colors.AppColor.lightGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: dimens
                                  .Dimens.emailContentHorizontalPaddingSignUp,
                              vertical: dimens
                                  .Dimens.emailContentVerticalPaddingSignUp),
                        ),
                        style: GoogleFonts.poppins(
                            color: colors.AppColor.tertiaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ))),

              Space(Get.height * 0.03),

              fieldTitle('Account name'),

              DelayedDisplay(
                  delay: const Duration(milliseconds: animationDuration),
                  child: SizedBox(
                      width: dimens.Dimens.emailContainerHeightSignUp,
                      child: TextFormField(
                        initialValue: widget.vault.vaultName,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: colors.AppColor.primaryColor,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: colors.AppColor.lightGrey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0, color: colors.AppColor.lightGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: dimens
                                  .Dimens.emailContentHorizontalPaddingSignUp,
                              vertical: dimens
                                  .Dimens.emailContentVerticalPaddingSignUp),
                        ),
                        style: GoogleFonts.poppins(
                            color: colors.AppColor.tertiaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ))),

              Space(Get.height * 0.03),

              fieldTitle('Password'),
              DelayedDisplay(
                delay: const Duration(milliseconds: animationDuration),
                child: SizedBox(
                  width: dimens.Dimens.emailContainerHeightSignUp,
                  child: GetBuilder<EditAccountController>(
                    initState: (state) {
                      editAccController.makePassTrue();
                    },
                    dispose: (state) {
                      editAccController.makePassTrue();
                    },
                      builder: (editAccController) {
                    return TextFormField(
                      initialValue: widget.vault.vaultPassword,
                      keyboardType:
                          editAccController.getPassToggle == false
                              ? TextInputType.visiblePassword
                              : TextInputType.emailAddress,
                      obscureText: editAccController.getPassToggle,
                     // readOnly: true,
                      cursorColor: Colors.grey,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.AppColor.lightGrey,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0, color: colors.AppColor.lightGrey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                        contentPadding: const EdgeInsets.only(left: 20),
                        suffixIcon: SizedBox(
                          width: Get.width*0.25,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  editAccController.getPassToggle == false ? editAccController.funPasswordToggle() : _buildShowTextField(context, path.getOptPass);
                                },
                                icon: editAccController.getPassToggle == false
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                iconSize: 20,
                                splashRadius: 20,
                                color: editAccController.getPassToggle == false
                                    ? Colors.redAccent
                                    : const Color.fromARGB(255, 36, 56, 70),
                              ),
                                IconButton(
                                  onPressed: (){
                                    _buildShowTextField(context, path.getOptCopy);
                                  }, 
                                  icon: const Icon(Icons.copy_all_rounded),
                                  color: colors.AppColor.tertiaryColor,
                                  iconSize: 20,
                                  splashRadius: 20,
                                )
                            ]
                          )
                        ),
                        suffixIconColor: Colors.grey,
                      ),
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                    );
                  }),
                ),
              ),

              Space(Get.height * 0.03),

              fieldTitle('Password Hint'),
              DelayedDisplay(
                  delay: const Duration(milliseconds: animationDuration),
                  child: SizedBox(
                    width: dimens.Dimens.emailContainerHeightSignUp,
                    child: TextFormField(
                      initialValue: widget.vault.hintPassword,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.AppColor.lightGrey,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0, color: colors.AppColor.lightGrey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      maxLines: 2,
                      minLines: 1,
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  )),
              Space(Get.height * 0.03),

              fieldTitle('Image Url'),

              DelayedDisplay(
                  delay: const Duration(milliseconds: animationDuration),
                  child: SizedBox(
                    width: dimens.Dimens.emailContainerHeightSignUp,
                    child: TextFormField(
                      initialValue: widget.vault.sourceImageUrl,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.AppColor.lightGrey,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0, color: colors.AppColor.lightGrey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.tertiaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  )),
              Space(Get.height * 0.03),

              titleWidget('Category'),

              Space(Get.height * 0.01),

              DelayedDisplay(
                  delay: const Duration(milliseconds: animationDuration),
                  child: SizedBox(
                      width: dimens.Dimens.emailContainerHeightSignUp,
                      child: TextFormField(
                        initialValue: widget.vault.vaultCategory,
                        enabled: false,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: colors.AppColor.lightGrey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0, color: colors.AppColor.lightGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        maxLines: 2,
                        minLines: 1,
                        style: GoogleFonts.poppins(
                            color: colors.AppColor.tertiaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ))),

              Space(Get.height * 0.01),

              // _buildCategoriesButtons(),

              Space(Get.height * 0.03),

              titleWidget('Advance Setup'),

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
                              activeColor: colors.AppColor.primaryColor,
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
                              'Use Master password to unlock ?',
                              style: GoogleFonts.poppins(
                                  color: colors.AppColor.accentColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              overflow: TextOverflow.fade,
                            ),
                            FlutterSwitch(
                              width: 50,
                              height: 30,
                              activeColor: colors.AppColor.primaryColor,
                              inactiveColor: colors.AppColor.lightGrey,
                              toggleColor: colors.AppColor.secondaryColor,
                              value: widget.vault.isMPUnlock,
                              disabled: true,
                              onToggle: (val) {},
                            ),
                          ]),
                    ]))
              ),

              Space(Get.height * 0.03),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _buildShowTextField(context, path.getOptEdit);
          
        },
        backgroundColor: colors.AppColor.tertiaryColor,
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget titleWidget(String title) {
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

  Widget fieldTitle(String title) {
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
          obscureText: editAccController.getPassToggle,
          hintText: 'Master Password',
          validator: (value) {
            
            if (value!.isEmpty) {
              return 'Please enter correct master password';
            } else {
              encryController.validateMasterPass(value, context, path, vault: widget.vault);
            }
          },
          
      )
    ]);
  }
}
