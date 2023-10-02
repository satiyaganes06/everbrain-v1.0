import 'package:emailjs/emailjs.dart';
import 'package:everbrain/core/localServices/device_info.dart';
import 'package:everbrain/core/networkService/hms_respository_impl.dart';
import 'package:everbrain/presentation/widget/global_widget.dart';
import 'package:everbrain/presentation/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';

import '../core/networkService/hms_respository.dart';
import 'login_controller.getx.dart';

class MasterPassswordHintController extends GetxController {
  final loginController = Get.find<LoginController>();
  final emailTextController = TextEditingController();

  Future<void> sendHintToEmail(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Loading();
        });

    String passwordHint = await loginController.getfirebaseService
        .getUserHints(emailTextController.text);
    String deviceOS = GetIt.I.get<DeviceInfo>().deviceOs;
    String deviceModel = GetIt.I.get<DeviceInfo>().deviceModel;
    String deviceIP = GetIt.I.get<DeviceInfo>().deviceIP;

    Map<String, dynamic> templateParams = {
      'user_email': emailTextController.text,
      'password_hint': passwordHint,
      'operating_system': deviceOS,
      'device_model': deviceModel,
      'device_ip': deviceIP,
    };

    if (passwordHint != 'No hint found') {
      try {
        await EmailJS.send(
          'service_jc5tgih',
          'template_8866jeb',
          templateParams,
          const Options(
            publicKey: '5uQj1mX5Zm49MBDRB',
            privateKey: 'xfXhxw_',
          ),
        );
        Navigator.of(context).pop();
        print('SUCCESS!');
        successMessage(context, 'Check you email for password hint');
      } catch (e) {
        Navigator.of(context).pop();
        failMessage(context, e.toString());

        print(e.toString());
      }
    } else {
      Navigator.of(context).pop();
      failMessage(context, 'No Email Found');
    }
  }

  Future<void> userDetectionFun(BuildContext context) async {
    await GetIt.I.get<HmsRepository>().userDetection().then((token) {
      
      if(token != null){
        sendHintToEmail(context);
      }else{
        failMessage(context, 'User not verified');
      }
    });
    
  }

  @override
  void dispose() {
    emailTextController.dispose();
    GetIt.I.get<HmsRepositoryImpl>().shutdownUserDetect();
    super.dispose();
  }
}
