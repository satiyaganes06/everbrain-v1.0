import 'package:cached_network_image/cached_network_image.dart';
import 'package:everbrain/controller/add_new_account_controller.getx.dart';
import 'package:everbrain/controller/password_generator.getx.dart';
import 'package:everbrain/controller/signup_controller.getx.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shimmer/shimmer.dart';

successMessage(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: colors.AppColor.success,
    duration: Duration(seconds: dimens.Dimens.snackMessageDuration),
  ));
}

failMessage(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: colors.AppColor.fail,
    duration: const Duration(seconds: 2),
  ));
}

textField(
    TextEditingController controller,
    String label,
    TextInputType textInputType,
    bool obscureText,
    bool readOnly,
    bool isHasInitialValue,
    bool isHasSuffix,
    {String? image}) {
  return SizedBox(
      width: dimens.Dimens.emailContainerHeightSignUp,
      child: TextFormField(
        initialValue: isHasInitialValue ? controller.text : null,
        controller: controller,
        readOnly: readOnly,
        keyboardType: textInputType,
        cursorColor: colors.AppColor.primaryColor,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: colors.AppColor.accentColor,
        ),
        onChanged: (value) {
          if(label == 'URL'){
            Get.find<AddNewAccountController>().checkUrl(value);
          }
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: colors.AppColor.lightGrey,
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            labelText: label,
            labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: colors.AppColor.subtitle2Color,
                letterSpacing: 0.3),
            contentPadding: EdgeInsets.symmetric(
                horizontal:
                    dimens.Dimens.textFieldContentHorizontalPaddingSignUp,
                vertical: dimens.Dimens.textFieldContentVerticalPaddingSignUp),
            suffix: isHasSuffix
                ? OctoImage.fromSet(
                  width: Get.height*0.04,
                  image: CachedNetworkImageProvider(image ?? ''),
                  octoSet: OctoSet.circleAvatar(
                    backgroundColor: colors.AppColor.secondaryColor, text: const Center(child: CircularProgressIndicator(),),
                  ),
                  fit: BoxFit.cover,
                )
                : const SizedBox(),),
            
        validator: (value) {
          switch (textInputType) {
            case TextInputType.emailAddress:
              if (value!.isEmpty) {
                return 'Please enter your email address';
              }
              return null;

            case TextInputType.text:
              if (value!.isEmpty) {

                return 'Please enter your ${label.toLowerCase()}';
                
                
              }else{
                if(label == 'Master Password Hints'){
                  
                  final signUpCtrl = Get.find<SignUpController>();

                  if(signUpCtrl.isHintValid() == false){
                    return 'Do not use your master password in hints';
                  }else{
                    return null;
                  }
                }else{
                  return null;
                }
                
              }
             

            default:
              return null;
          }
        },
      ));
}

toggle({required String title, required bool value}) {
  final passwordGeneratorCtrl = Get.find<PasswordGenerator>();
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(
      title,
      style: GoogleFonts.poppins(
          color: colors.AppColor.accentColor,
          fontWeight: FontWeight.w500,
          fontSize: 14),
      overflow: TextOverflow.fade,
    ),
    FlutterSwitch(
      width: 50,
      height: 30,
      activeColor: colors.AppColor.success2,
      inactiveColor: colors.AppColor.lightGrey,
      toggleColor: colors.AppColor.secondaryColor,
      value: value,
      onToggle: (val){
        if(title == 'Numbers (123)'){
          passwordGeneratorCtrl.isNumbersToggle();
        }else if(title == 'Symbols (!@#)'){
          passwordGeneratorCtrl.isSymbolsToggle();
        }else if(title == 'Lowercase letters (abc)'){
          passwordGeneratorCtrl.isLowerCaseToggle();
        }else if(title == 'Uppercase letters (ABC)'){
          passwordGeneratorCtrl.isUpperCaseToggle();
        }
      },
    ),
  ]);
}

shimmerEffectBrandSearch(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: SizedBox(
    height: 50.0,
    child: Shimmer.fromColors(
      baseColor: colors.AppColor.lightGrey.withOpacity(0.6),
      highlightColor: colors.AppColor.lightGrey,
      child: ListTile(
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
        ),
        title: Container(
          height: Get.height*0.02,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          )
        ),
      )
    ),
  )
  );
}
