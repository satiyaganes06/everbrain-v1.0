import 'package:auto_animated/auto_animated.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/Controller/dashboard_controller.dart';
import 'package:everbrain/Controller/flutter_encry_controller.dart';
import 'package:everbrain/presentation/Widget/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import '../../../../Controller/edit_account_controller.dart';
import '../../../../Model/vault_model.dart';
import '../../../Widget/category_button.dart';
import '../../../Widget/subtitle_font copy.dart';
import '../../../../core/path/path.dart';

class EditAccountScreen extends StatefulWidget {
  Vault vault;
  EditAccountScreen({super.key, required this.vault});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final formkey = GlobalKey<FormState>();
  final editAccountController = Get.find<EditAccountController>();
  final dashboardController = Get.find<DashboardController>();
  final encryController = Get.find<FlutterEncryController>();
  final path = Paths();

  @override
  void initState() {
    
    editAccountController.editSetup(widget.vault);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
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
            constants.Constants.editAccountTitle,
            style: GoogleFonts.poppins(
                color: colors.AppColor.secondaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {

                  _buildShowTextField(path.getOptDelete);
                },
                icon: const Icon(Icons.delete_rounded))
          ],
        ),
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
                      titleWidget('Account Information'),
                      Space(Get.height * 0.01),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  editAccountController.animationDuration),
                          child: SizedBox(
                              width: dimens.Dimens.emailContainerHeightSignUp,
                              child: TextFormField(
                                controller: editAccountController.companyName,
                                keyboardType: TextInputType.name,
                                cursorColor: colors.AppColor.primaryColor,
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
                                  hintText: 'Enter name',
                                  hintStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: dimens.Dimens.emailFontSizeSignUp,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: dimens.Dimens
                                          .emailContentHorizontalPaddingSignUp,
                                      vertical: dimens.Dimens
                                          .emailContentVerticalPaddingSignUp),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                    return "Enter correct name";
                                  } else {
                                    return null;
                                  }
                                },
                              ))),
                      Space(Get.height * 0.03),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  editAccountController.animationDuration),
                          child: SizedBox(
                              width: dimens.Dimens.emailContainerHeightSignUp,
                              child: TextFormField(
                                controller:
                                    editAccountController.emailRusernameRphone,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: colors.AppColor.primaryColor,
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
                                  hintText: 'Email/Username/Phone number',
                                  hintStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: dimens.Dimens.emailFontSizeSignUp,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: dimens.Dimens
                                          .emailContentHorizontalPaddingSignUp,
                                      vertical: dimens.Dimens
                                          .emailContentVerticalPaddingSignUp),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter valid email/esername/phone number";
                                  } else {
                                    return null;
                                  }
                                },
                              ))),
                      Space(Get.height * 0.03),
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  editAccountController.animationDuration),
                          child: SizedBox(
                            width: dimens.Dimens.emailContainerHeightSignUp,
                            child: GetBuilder<EditAccountController>(
                              initState: (state) {
                                editAccountController.makePassTrue();
                              },
                              dispose: (state) {
                                editAccountController.makePassTrue();
                              },
                                builder: (_) {
                              return TextFormField(
                                controller: editAccountController.password,
                                keyboardType:TextInputType.visiblePassword,
                                obscureText:
                                    editAccountController.getPassToggle,
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
                                      editAccountController.getPassToggle == false ? editAccountController.funPasswordToggle() : _buildShowTextField(path.getOptPass);

                                      
                                    },
                                    icon: editAccountController
                                                .getPassToggle ==
                                            false
                                        ? const Icon(
                                            Icons.visibility_off_outlined)
                                        : const Icon(Icons.visibility_outlined),
                                    iconSize: 20,
                                    splashRadius: 20,
                                    color:
                                        editAccountController.getPassToggle ==
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
                      DelayedDisplay(
                          delay: Duration(
                              milliseconds:
                                  editAccountController.animationDuration),
                          child: SizedBox(
                              width: dimens.Dimens.emailContainerHeightSignUp,
                              child: TextFormField(
                                controller: editAccountController.hintPassword,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: colors.AppColor.lightGrey,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: colors.AppColor.lightGrey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Write some hints',
                                  hintStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                ),
                                maxLines: 2,
                                minLines: 1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter hints for password";
                                  } else {
                                    return null;
                                  }
                                },
                              ))),
                              Space(Get.height*0.03),

                    DelayedDisplay(
                      delay:  Duration(milliseconds: editAccountController.animationDuration),
                      child: SizedBox(
                        width: dimens.Dimens.emailContainerHeightSignUp,
                        child: TextFormField(
                          controller: editAccountController.searchCompanyName,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            filled: true, 
                            fillColor: colors.AppColor.lightGrey,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Image Url',
                            hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          validator: (value){
                              if(value!.isEmpty){
                              return "Enter valid url";
                            }else{
                              return null;
                            }
                            
                          },
                        )
                      )
                    ),
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
                                editAccountController.animationDuration),
                        child:
                            GetBuilder<EditAccountController>(builder: (_) {
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
                                            colors.AppColor.primaryColor,
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
                                        activeColor:
                                            colors.AppColor.primaryColor,
                                        inactiveColor:
                                            colors.AppColor.lightGrey,
                                        toggleColor:
                                            colors.AppColor.secondaryColor,
                                        value: editAccountController
                                            .isReMpassNeeded,
                                        onToggle: (val) {
                                          editAccountController
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
                                editAccountController.animationDuration),
                        child: Material(
                            color: const Color.fromARGB(255, 36, 56, 70),
                            borderRadius: BorderRadius.circular(20),
                            shadowColor: Colors.grey[200],
                            elevation: 6.1,
                            child: InkWell(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  dashboardController.updateVault(
                                      widget.vault, context);
                                  
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
                    color: editAccountController
                                .category_Selector_List.value[index] ==
                            false
                        ? Colors.white
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          editAccountController.filterToggle(index);
                        },
                        child: CategoryButton(
                            editAccountController
                                .category_Button_Image_Path[index],
                            editAccountController
                                .category_Button_Image_title[index])));
              })));

  Widget _buildCategoriesButtons() {
    return SizedBox(
        height: Get.height * 0.15,
        child: LiveGrid.options(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          options: dashboardController.options,
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
        delay: Duration(milliseconds: editAccountController.animationDuration),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SubtitleFont(title.toString()),
          ),
          Space(10)
        ]));
  }

  _buildShowTextField(int path) {
    return showTextInputDialog(context: context, textFields: [
      DialogTextField(
          obscureText: editAccountController.getPassToggle,
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
