import 'package:everbrain/controller/login_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../core/networkService/hms_respository.dart';
import '../presentation/Widget/global_widget.dart';
import '../presentation/widget/loading.dart';

class SecurityQuestionController extends GetxController {
  final question1Ctrl = TextEditingController();
  final question2Ctrl = TextEditingController();
  final question3Ctrl = TextEditingController();
  final question4Ctrl = TextEditingController();

  Rx<bool> isLoading = false.obs;

  var data;
  bool isUpdate = false;

  List<String> questionList = [
    'What is the name of your favorite book or movie?',
    'What was the model of your first car?',
    'What is your favorite childhood memory?',
    'What was the first concert you attended?',
  ];

  @override
  onInit() async {
    isLoading.value = true;
    data = await Get.find<LoginController>()
            .firebaseService
            .getSecurityQuestion() ??
        [];

    try {
      if (data[0] != null) {
      question1Ctrl.text =
          data[0]['What is the name of your favorite book or movie?'];
      question2Ctrl.text = data[0]['What was the model of your first car?'];
      question3Ctrl.text = data[0]['What is your favorite childhood memory?'];
      question4Ctrl.text = data[0]['What was the first concert you attended?'];
      
      isUpdate = true;
    }
    } catch (e) {
      isLoading.value = false;
    }

    isLoading.value = false;
    super.onInit();
  }

  Future<void> userDetectionFun(BuildContext context) async {
    await GetIt.I.get<HmsRepository>().userDetection().then((token) {
      if (token != null) {
        storeSecurityQuestion(context);
      } else {
        failMessage(context, 'User not verified');
      }
    });
  }

  void storeSecurityQuestion(BuildContext context) {
    if (isUpdate) {
      showDialog(
          context: context,
          builder: (context) {
            return const Loading();
          });
      Get.find<LoginController>()
          .firebaseService
          .updateSecurityQuestion(
              questionList,
              question1Ctrl.text,
              question2Ctrl.text,
              question3Ctrl.text,
              question4Ctrl.text,
              context, data[1])
          .catchError((onError) {
        Get.back();
        failMessage(context, onError.toString());
        Get.back();
      }).whenComplete(() {
        Get.back();
        successMessage(context, 'Security question updated successfully');
        Get.back();
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const Loading();
          });
      Get.find<LoginController>()
          .firebaseService
          .saveSecurityQuestion(
              questionList,
              question1Ctrl.text,
              question2Ctrl.text,
              question3Ctrl.text,
              question4Ctrl.text,
              context)
          .catchError((onError) {
        Get.back();
        failMessage(context, onError.toString());
        Get.back();
      }).whenComplete(() {
        Get.back();
        successMessage(context, 'Security question saved successfully');
        Get.back();
      });
    }
  }

  @override
  void dispose() {
    question1Ctrl.dispose();
    question2Ctrl.dispose();
    question3Ctrl.dispose();
    question4Ctrl.dispose();
    super.dispose();
  }
}
