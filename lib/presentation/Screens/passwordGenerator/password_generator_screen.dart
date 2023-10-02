import 'package:auto_size_text/auto_size_text.dart';
import 'package:everbrain/presentation/widget/space.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../controller/password_generator.getx.dart';
import '../../widget/appbar.dart';
import '../../widget/global_widget.dart';

class PasswordGeneratorScreen extends StatelessWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passGeneratorCtrl = Get.put(PasswordGenerator());
    return Scaffold(
      appBar: CommonAppbar(
        title: 'Password Generator',
        isActionBtnEnable: false,
        isBackBtnEnable: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Container(
              padding: const EdgeInsets.all(20),
              color: passGeneratorCtrl.passwordStrengthColor.value
                  .withOpacity(0.3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      //color:Colors.amber,
                      height: Get.height * 0.15,
                      child: Center(
                        child: AutoSizeText(
                          passGeneratorCtrl.generatedPassword.value,
                          maxFontSize: 28,
                          minFontSize: 21,
                          style: GoogleFonts.poppins(
                              color: colors.AppColor.accentColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.0),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          //  overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Space(Get.height * 0.015),
                    LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      percent: passGeneratorCtrl.passwordStrength / 100,
                      progressColor:
                          passGeneratorCtrl.passwordStrengthColor.value,
                      backgroundColor: colors.AppColor.secondaryColor,
                      lineHeight: 3,
                      barRadius: const Radius.circular(50),
                      animateFromLastPercent: true,
                      animation: true,
                    ),
                    Space(Get.height * 0.02),
                    Text(
                      passGeneratorCtrl.passwordStrengthText.value,
                      style: GoogleFonts.poppins(
                          color: passGeneratorCtrl.passwordStrengthColor.value,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 0),
                    ),
                    Space(2),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Time to crack: ',
                          style: GoogleFonts.poppins(
                              color: colors.AppColor.accentColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 0),
                        ),
                        TextSpan(
                          text: passGeneratorCtrl.timeOfCrack.value,
                          style: GoogleFonts.poppins(
                              color: colors.AppColor.accentColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0),
                        ),
                      ]),
                    ),
                  ]),
            );
          }),
          Space(Get.height * 0.05),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Password length :  ',
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.accentColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0),
                    ),
                    TextSpan(
                      text:
                          '${passGeneratorCtrl.characterLength.value.round()} characters',
                      style: GoogleFonts.poppins(
                          color: colors.AppColor.accentColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0),
                    ),
                  ]),
                ),
              )),
          Obx(() => Slider(
                min: 4.0,
                max: 64.0,
                thumbColor: colors.AppColor.tertiaryColor,
                activeColor: colors.AppColor.tertiaryColor,
                inactiveColor: colors.AppColor.lightGrey,
                value: passGeneratorCtrl.characterLength.value,
                onChanged: (value) {
                  passGeneratorCtrl.updatePasswordFun(value);
                  passGeneratorCtrl.updatePasswordStrength(value);
                },
              )),
          Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                toggle(
                    title: 'Lowercase letters (abc)',
                    value: passGeneratorCtrl.isLowerCase.value),
                Space(Get.height * 0.01),
                toggle(
                    title: 'Uppercase letters (ABC)',
                    value: passGeneratorCtrl.isUpperCase.value),
                Space(Get.height * 0.01),
                toggle(
                    title: 'Numbers (123)',
                    value: passGeneratorCtrl.isNumbers.value),
                Space(Get.height * 0.01),
                toggle(
                    title: 'Symbols (!@#)',
                    value: passGeneratorCtrl.isSymbols.value),
              ]))),
          Space(Get.height * 0.05),
        ],
      )),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    
                    passGeneratorCtrl.updatePasswordFun(
                        passGeneratorCtrl.characterLength.value);
                  },
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: colors.AppColor.tertiaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Icon(
                      Icons.refresh_rounded,
                      size: 25,
                      color: colors.AppColor.secondaryColor,
                    ),
                  )),
              const SizedBox(
                width: 1,
              ),
              GestureDetector(
                  onTap: () {
                    passGeneratorCtrl.funPasswordCopy(context);
                  },
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: colors.AppColor.tertiaryColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Icon(Icons.copy_all_rounded,
                        size: 23, color: colors.AppColor.secondaryColor),
                  ))
            ],
          )),
    );
  }
}

// Container(
//               height: Get.height * 0.15,
//               padding: const EdgeInsets.all(20),
//               color: colors.AppColor.lightGrey,
//               child: Container(
//                 color:colors.AppColor.lightGrey,
//                 height: 20,
//                 child: Column(
//                   children: [
//                     Obx(() {
//                         return Column(
//                           children: [
//                             Slider(
//                               min: 8.0,
//                               max: 64.0,
//                               value: passGeneratorCtrl.characterLength.value,
//                               onChanged: (value) {
//                                 passGeneratorCtrl.updatePasswordStrength(value);
//                               },
                            
//                             ),
//                             Text(
//                               'Password Strength: ${passGeneratorCtrl.characterLength.value.round()}',
//                               style: GoogleFonts.poppins(
//                                 color: colors.AppColor.accentColor,
//                                 fontWeight: FontWeight.w500,
//                                 letterSpacing: 1.5
//                               ),
//                             ),
//                           ]
//                         );
//                       }
//                     )
//                   ],
//                 ),
//               )
//             )