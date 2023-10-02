// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_animated/auto_animated.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/presentation/Screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:everbrain/controller/add_new_account_controller.getx.dart';
import 'package:everbrain/controller/dashboard_controller.getx.dart';
import 'package:everbrain/controller/password_generator.getx.dart';
import 'package:everbrain/model/brand_model.dart';
import 'package:everbrain/presentation/widget/space.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;

import '../../../widget/appbar.dart';
import '../../../widget/category_button.dart';
import '../../../widget/global_widget.dart';
import '../../../widget/subtitle_font copy.dart';
import '../../dashboard/dashboard_Screen.dart';

class AddNewAccount extends StatefulWidget {
  String? brandIcon;
  String? brandDomain;
  String? brandName;

  AddNewAccount({
    Key? key,
    this.brandIcon,
     this.brandDomain,
     this.brandName
  }) : super(key: key);

  @override
  State<AddNewAccount> createState() => _AddNewAccountState();
}

class _AddNewAccountState extends State<AddNewAccount> {
  final formkey = GlobalKey<FormState>();
  final addNewAccountController = Get.put(AddNewAccountController());
  final dashboardController = Get.find<DashboardController>();

  @override
  initState() {
    addNewAccountController.vaultWebsiteURLCtrl.text = widget.brandDomain ?? 'https://';
    addNewAccountController.vaultNameCtrl.text = widget.brandName ?? '';
    addNewAccountController.vaultWebsiteImageUrl = widget.brandIcon ?? 'https://firebasestorage.googleapis.com/v0/b/everbrain-a6262.appspot.com/o/Company%20Logo%2Fempty_icon_2.png?alt=media&token=65e83cc8-8bd6-4401-aa67-aa8cb449b529';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: CommonAppbar(
            title: constants.Constants.addAccountTitle,),
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: formkey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space(Get.height * 0.03),
                      titleWidget('Vault Information'),
                      Space(Get.height * 0.02),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  dimens.Dimens.delayAnimationLogInPage),
                          child: textField(
                              addNewAccountController.vaultNameCtrl,
                              'Name',
                              TextInputType.text,
                              false,
                              false,
                              false,
                              true , image: addNewAccountController.vaultWebsiteImageUrl)),
                      Space(Get.height * 0.03),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  dimens.Dimens.delayAnimationLogInPage),
                          child: textField(
                              addNewAccountController.vaultUsernameCtrl,
                              'Email/Username/Phone',
                              TextInputType.text,
                              false,
                              false,
                              false,
                              false)),
                      Space(Get.height * 0.03),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  dimens.Dimens.delayAnimationLogInPage),
                          child: SizedBox(
                            width: dimens.Dimens.emailContainerHeightSignUp,
                            child: GetBuilder<AddNewAccountController>(
                                builder: (addNewAccountController) {
                              return TextFormField(
                                controller:
                                    addNewAccountController.vaultPasswordCtrl,
                                keyboardType:
                                    addNewAccountController.passwordToggle ==
                                            false
                                        ? TextInputType.visiblePassword
                                        : TextInputType.emailAddress,
                                obscureText:
                                    addNewAccountController.passwordToggle,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: colors.AppColor.lightGrey,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: colors.AppColor.lightGrey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: colors.AppColor.lightGrey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: colors.AppColor.lightGrey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: colors.AppColor.subtitle2Color,
                                      letterSpacing: 0.5),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: dimens.Dimens
                                          .textFieldContentHorizontalPaddingSignUp,
                                      vertical: dimens.Dimens
                                          .textFieldContentVerticalPaddingSignUp),
                                  suffixIcon: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          addNewAccountController
                                              .funPasswordToggle();
                                        },
                                        icon: addNewAccountController
                                                    .passwordToggle ==
                                                false
                                            ? const Icon(
                                                Icons.visibility_off_outlined)
                                            : const Icon(Icons.visibility_outlined),
                                        iconSize: 20,
                                        splashRadius: 20,
                                        color: addNewAccountController
                                                    .passwordToggle ==
                                                false
                                            ? colors.AppColor.fail
                                            : colors.AppColor.accentColor,
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          Get.lazyPut(() => PasswordGenerator());
                                           Get.find<PasswordGenerator>().updatePasswordFun(12);
                                          addNewAccountController.vaultPasswordCtrl.text = Get.find<PasswordGenerator>().generatedPassword.value;
                                        },
                                        icon: const Icon(Icons.password_rounded),
                                        iconSize: 20,
                                        splashRadius: 20,
                                        color: colors.AppColor.accentColor,
                                        tooltip: 'Generate 12 digit password',
                                      ),
                                    ]
                                  ),
                                  suffixIconColor: Colors.grey,
                                ),
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  }// } else {
                                  //  // if (!regex.hasMatch(value)) {
                                  //     return 'Enter valid password';
                                  //   //} else {
                                  //   //  return null;
                                  //  // }
                                  // }
                                },
                              );
                            }),
                          )),
                      Space(Get.height * 0.03),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  dimens.Dimens.delayAnimationLogInPage),
                          child: textField(
                              addNewAccountController.vaultWebsiteURLCtrl,
                              'URL',
                              TextInputType.text,
                              false,
                              false,
                              false,
                              false)),
                      Space(Get.height * 0.01),
                      Obx(() => DelayedDisplay(
                        delay: Duration(milliseconds:
                                  dimens.Dimens.delayAnimationLogInPage),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(addNewAccountController.urlCheckResult.value,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: addNewAccountController.urlCheckResultColor.value,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                        )
                      )),
                      Space(Get.height * 0.03),
                      titleWidget('Category'),
                      Space(Get.height * 0.01),
                      _buildCategoriesButtons(),
                      Space(Get.height * 0.03),
                      titleWidget('Advance Setup'),
                      Space(Get.height * 0.01),
                      DelayedDisplay(
                        delay: Duration(
                            milliseconds:
                                dimens.Dimens.delayAnimationLogInPage),
                        child:
                            GetBuilder<AddNewAccountController>(builder: (_) {
                          return Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Favourite ?',
                                        style: GoogleFonts.poppins(
                                            color: colors.AppColor.accentColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                      FlutterSwitch(
                                        width: 50,
                                        height: 30,
                                        activeColor:
                                            colors.AppColor.success2,
                                        inactiveColor:
                                            colors.AppColor.lightGrey,
                                        toggleColor:
                                            colors.AppColor.secondaryColor,
                                        value:
                                            addNewAccountController.isFavourite,
                                        onToggle: (val) {
                                          addNewAccountController
                                              .favouriteToggle();
                                        },
                                      ),
                                    ]),
                                Space(Get.height * 0.01),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        activeColor:
                                            colors.AppColor.success2,
                                        inactiveColor:
                                            colors.AppColor.lightGrey,
                                        toggleColor:
                                            colors.AppColor.secondaryColor,
                                        value: addNewAccountController
                                            .isBiometricEnable,
                                        onToggle: (val) {
                                          addNewAccountController
                                              .reMpassNeededToggle();
                                        },
                                      ),
                                    ]),
                              ]));
                        }),
                      ),

                      Space(Get.height * 0.03),

                      DelayedDisplay(
                        delay: Duration(
                            milliseconds:
                                dimens.Dimens.delayAnimationLogInPage),
                        child: Material(
                            color: const Color.fromARGB(255, 36, 56, 70),
                            borderRadius: BorderRadius.circular(20),
                            shadowColor: Colors.grey[200],
                            elevation: 6.1,
                            child: Obx(()  {
                                return InkWell(
                                  onTap:  addNewAccountController.isSubmitBtnEnable.value ? (){
                                    if (formkey.currentState!.validate()) {
                                      addNewAccountController.addAccountFun();

                                      Get.offAll(const MainScreen());
                                    }
                                  } : null,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    color: Colors.transparent,
                                    child: Center(
                                        child: Text(
                                      'Save Account',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    )),
                                  ),
                                );
                              }
                            )),
                      ),
                      Space(50)
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _buildAnimatedCategoryButton(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          // And slide transition
          child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Obx(() {
                return Material(
                    color: addNewAccountController
                                .category_Selector_List.value[index] ==
                            false
                        ? Colors.white
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          addNewAccountController.filterToggle(index);
                        },
                        child: CategoryButton(
                            addNewAccountController
                                .category_Button_Image_Path[index],
                            addNewAccountController
                                .category_Button_Image_title[index])));
              })));

  Widget _buildCategoriesButtons() {
    return SizedBox(
        height: Get.height * 0.06,
        child: LiveGrid.options(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          options: dashboardController.options,
          itemBuilder: _buildAnimatedCategoryButton,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 1,
            mainAxisExtent: Get.width*0.4
          ),
          physics: const BouncingScrollPhysics(),
        ));
  }

  Widget titleWidget(String title) {
    return DelayedDisplay(
        delay: Duration(milliseconds: dimens.Dimens.delayAnimationLogInPage),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SubtitleFont(title.toString()),
          ),
          Space(10)
        ]));
  }
}
