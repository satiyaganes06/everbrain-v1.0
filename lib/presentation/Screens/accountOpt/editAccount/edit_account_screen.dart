import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/controller/dashboard_controller.getx.dart';
import 'package:everbrain/controller/flutter_encry_controller.getx.dart';
import 'package:everbrain/presentation/Screens/searchBrand/search_brand_screen.dart';
import 'package:everbrain/presentation/Widget/loading.dart';
import 'package:everbrain/presentation/Widget/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/keys.dart' as KY;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:octo_image/octo_image.dart';
import '../../../../controller/edit_account_controller.getx.dart';
import '../../../../Model/vault_model.dart';
import '../../../../controller/hive_controller.getx.dart';
import '../../../Widget/appbar.dart';
import '../../../Widget/category_button.dart';
import '../../../Widget/global_widget.dart';
import '../../../Widget/subtitle_font copy.dart';
import '../viewAccount/widget/view_text_field.dart';

class EditAccountScreen extends StatefulWidget {
  Vault vault;
  EditAccountScreen({super.key, required this.vault});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final editAccountController = Get.find<EditAccountController>();

  @override
  void initState() {
    editAccountController.editSetup(widget.vault);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    final encryController = Get.find<FlutterEncryController>();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final hiveCtrl = Get.find<HiveController>();
    return Scaffold(
        key: _scaffoldKey,
        appBar: CommonAppbar(
            title: constants.Constants.editAccountTitle,
            isActionBtnEnable: true,
            icon: const Icon(Iconsax.trash4),
            actionBtnFunction: () {
              !widget.vault.isBiometricUnlock
                  ? _buildShowTextField(
                      KY.KYS.optDelete, encryController, context)
                  : encryController.biometricUnlock(
                      optValue: KY.KYS.optDelete,
                      title: 'delete account',
                      context: context,
                      vault: widget.vault);
            }),
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: formkey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Space(Get.height * 0.03),
                      titleWidget('Vault Information'),
                      Space(Get.height * 0.02),

                      DelayedDisplay(
                        delay: Duration(
                            milliseconds:
                                dimens.Dimens.delayAnimationLogInPage),
                        child: GestureDetector(
                          onTap: (){
                            
                            var result = Get.to(()=>SearchBrandScreen(isFromEdit: true,));

                            print(result);
                          
                          },
                          child: OctoImage.fromSet(
                                          width: Get.height*0.04,
                                          image: CachedNetworkImageProvider(widget.vault.websiteImageUrl),
                                          octoSet: OctoSet.circleAvatar(
                                            backgroundColor: colors.AppColor.secondaryColor, text: const Center(child: CircularProgressIndicator(),),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                        ),
                      ),

                Space(Get.height * 0.02),
                      DelayedDisplay(
                        delay: Duration(
                            milliseconds:
                                dimens.Dimens.delayAnimationLogInPage),
                        child:  textField(
                              editAccountController.vaultNameEditCtrl,
                              'Name',
                              TextInputType.text,
                              false,
                              false,
                              false,
                              false)
                        
                      ),
                      Space(Get.height * 0.03),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  dimens.Dimens.delayAnimationLogInPage),
                          child: textField(
                              editAccountController.vaultUsernameEditCtrl,
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
                            child: GetBuilder<EditAccountController>(
                                initState: (state) {
                              editAccountController.makePassTrue();
                            }, dispose: (state) {
                              editAccountController.makePassTrue();
                            }, builder: (_) {
                              return TextFormField(
                                controller:
                                    editAccountController.vaultPasswordEditCtrl,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText:
                                    editAccountController.getPassEditToggle,
                                cursorColor: Colors.grey,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: colors.AppColor.lightGrey,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: colors.AppColor.lightGrey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      editAccountController.funPasswordEditToggle();
                                      //         false
                                      // editAccountController.getPassToggle ==
                                      //         false
                                      //     ? editAccountController
                                      //         .funPasswordToggle()
                                      //     : !widget.vault.isBiometricUnlock
                                      //         ? _buildShowTextField(
                                      //             KY.KYS.optPass,
                                      //             encryController,
                                      //             context)
                                      //         : encryController.biometricUnlock(
                                      //             optValue: KY.KYS.optPass,
                                      //             title: 'unlock password',
                                      //             context: context,
                                      //             vault: widget.vault);
                                    },
                                    icon: editAccountController.getPassEditToggle ==
                                            false
                                        ? const Icon(
                                            Icons.visibility_off_outlined)
                                        : const Icon(Icons.visibility_outlined),
                                    iconSize: 20,
                                    splashRadius: 20,
                                    color:
                                        editAccountController.getPassEditToggle ==
                                                false
                                            ? Colors.redAccent
                                            : Color.fromARGB(255, 36, 56, 70),
                                  ),
                                  suffixIconColor: Colors.grey,
                                ),
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  } 
                                  
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
                              editAccountController.vaultWebsiteURLEditCtrl,
                              'URL',
                              TextInputType.text,
                              false,
                              false,
                              false,
                              false)),
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
                        child: GetBuilder<EditAccountController>(
                          builder: (_) {
                          return Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        activeColor:
                                            colors.AppColor.success2,
                                        inactiveColor:
                                            colors.AppColor.lightGrey,
                                        toggleColor:
                                            colors.AppColor.secondaryColor,
                                        value:
                                            editAccountController.isFavourite,
                                        onToggle: (val) {
                                          editAccountController
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
                                        value: editAccountController
                                            .isBiometricEnable,
                                        onToggle: (val) {
                                          editAccountController
                                              .isBiometricNeededToggle();
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
                            child: InkWell(
                              onTap: () async{
                                if (formkey.currentState!.validate()) {
                                    await hiveCtrl.updateVaultPassword(widget.vault.vaultID, editAccountController.vaultPasswordEditCtrl.text, context);
                                    await hiveCtrl.updateVault(widget.vault, context);
                                 
                                }
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                color: Colors.transparent,
                                child: Center(
                                    child: Text(
                                  'Save',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )),
                              ),
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
                    color: Get.find<EditAccountController>()
                                .category_Selector_List
                                .value[index] ==
                            false
                        ? Colors.white
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Get.find<EditAccountController>().filterToggle(index);
                        },
                        child: CategoryButton(
                            Get.find<EditAccountController>()
                                .category_Button_Image_Path[index],
                            Get.find<EditAccountController>()
                                .category_Button_Image_title[index])));
              })));

  Widget _buildCategoriesButtons() {
    return SizedBox(
        height: Get.height * 0.15,
        child: LiveGrid.options(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          options: Get.find<DashboardController>().options,
          itemBuilder: _buildAnimatedCategoryButton,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 1,
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

  _buildShowTextField(int path, encryController, BuildContext context) {
    final editCtrl = Get.find<EditAccountController>();
    return showTextInputDialog(context: context, textFields: [
      DialogTextField(
        obscureText: true,
        hintText: 'Master Password',
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter correct master password';
          } else {
            encryController.validateMasterPass(value, context, path,
                vault: widget.vault);
          }
        },
      )
    ]);
  }
}
