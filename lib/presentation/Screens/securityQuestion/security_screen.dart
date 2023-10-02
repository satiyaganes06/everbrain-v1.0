import 'package:everbrain/presentation/Screens/accountOpt/viewAccount/widget/view_text_field.dart';
import 'package:everbrain/presentation/Widget/global_widget.dart';
import 'package:everbrain/presentation/widget/custom_appbar.dart';
import 'package:everbrain/presentation/widget/loading.dart';
import 'package:everbrain/presentation/widget/pageTitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:hive/hive.dart';
import '../../../controller/security_question_controller.getx.dart';
import '../../widget/appbar.dart';
import '../../widget/space.dart';
import '../../widget/subtitle2_font.dart';

class SecurityQuestionScreen extends StatelessWidget {
  SecurityQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final securityQuesCtrl = Get.put(SecurityQuestionController());

    return Scaffold(
      appBar: CommonAppbar(
        title: 'Security',
        isBackBtnEnable: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(() {
            return securityQuesCtrl.isLoading == false
                ? Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subtitle2Font('What is the name of your favorite book or movie?'),

                        Space(
                          Get.height * 0.02,
                        ),

                        PageTitle(
                            'Fill this question for security purpose', 16),

                        Space(
                          Get.height * 0.02,
                        ),

                        questionTitle(
                            'What is the name of your favorite book or movie?'),

                        Space(
                          Get.height * 0.01,
                        ),

                        textFieldSecurity(securityQuesCtrl.question1Ctrl),

                        Space(
                          Get.height * 0.03,
                        ),

                        questionTitle('What was the model of your first car?'),

                        Space(
                          Get.height * 0.01,
                        ),

                        textFieldSecurity(securityQuesCtrl.question2Ctrl),

                        Space(
                          Get.height * 0.03,
                        ),

                        questionTitle(
                            'What is your favorite childhood memory?'),

                        Space(
                          Get.height * 0.01,
                        ),

                        textFieldSecurity(securityQuesCtrl.question3Ctrl),

                        Space(
                          Get.height * 0.03,
                        ),

                        questionTitle(
                            'What was the first concert you attended?'),

                        Space(
                          Get.height * 0.01,
                        ),

                        textFieldSecurity(securityQuesCtrl.question4Ctrl),

                        Space(
                          Get.height * 0.05,
                        ),

                        Material(
                            color: colors.AppColor.tertiaryColor,
                            borderRadius: BorderRadius.circular(20),
                            shadowColor: Colors.grey[200],
                            elevation: 6.1,
                            child: InkWell(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  securityQuesCtrl.userDetectionFun(context);
                                }
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                color: Colors.transparent,
                                child: Center(
                                    child: Text(
                                  securityQuesCtrl.isUpdate ? 'Update' : 'Save',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )),
                              ),
                            )),
                      ],
                    ),
                  )
                :  SizedBox(
                  height: Get.height * 0.8,
                  child: Center(child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.AppColor.shadowColor.withOpacity(0.2),
                    ),
                    child: const  Loading()
                  ),
                ),);
          }),
        ),
      ),
    );
  }

  Text questionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: colors.AppColor.accentColor.withOpacity(0.8),
      ),
    );
  }

  TextFormField textFieldSecurity(
    TextEditingController questionCtrl,
  ) {
    return TextFormField(
        //initialValue: isHasInitialValue ? controller.text : null,
        controller: questionCtrl,
        keyboardType: TextInputType.text,
        cursorColor: colors.AppColor.primaryColor,
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: colors.AppColor.accentColor,
        ),
        decoration: InputDecoration(
            filled: true,
            fillColor: colors.AppColor.lightGrey,
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: colors.AppColor.lightGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: 'Enter your answer',
            hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: colors.AppColor.subtitle2Color,
                letterSpacing: 0.3),
            contentPadding: EdgeInsets.symmetric(
                horizontal:
                    dimens.Dimens.textFieldContentHorizontalPaddingSignUp,
                vertical: dimens.Dimens.textFieldContentVerticalPaddingSignUp)),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your answer';
          }
          return null;
        });
  }
}
