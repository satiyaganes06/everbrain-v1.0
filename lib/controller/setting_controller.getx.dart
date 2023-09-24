import 'package:everbrain/controller/local_auth_controller.getx.dart';
import 'package:everbrain/core/localServices/local_auth.dart';
import 'package:everbrain/presentation/Widget/global_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:everbrain/utils/keys.dart' as KY;
import 'package:url_launcher/url_launcher.dart';
import '../core/localServices/secure_storage_repository.dart';
import 'flutter_encry_controller.getx.dart';
import 'login_controller.getx.dart';

class SettingController extends GetxController {
  List<String> settingOption = ['off', 'on'];

  Rx<String> currentBiometricOption = ''.obs;
  Rx<String> currentPasscodeOption = ''.obs;
  String userID = '';

  @override
  void onInit() async {
    userID =  await GetIt.I.get<LocalStorageSecure>().getString('userID') ?? '';
    await getBiometricOption();
    await getPasscodeOption();
    super.onInit();
  }

  Future<void> setBiometricOption(String option, BuildContext context) async {
    if (option == settingOption[1]) {
      if (await LocalAuth.hasBiometrics()) {
        currentBiometricOption.value = option;

        

        GetIt.I
            .get<LocalStorageSecure>()
            .saveString(KY.KYS.isBiometric +  userID, currentBiometricOption.value);

        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        failMessage(
            context, 'Your device does not support biometric authentication');
      }
    } else {
      currentBiometricOption.value = option;

      GetIt.I
          .get<LocalStorageSecure>()
          .saveString(KY.KYS.isBiometric + userID, currentBiometricOption.value);

      Navigator.pop(context);
    }
  }

  Future<void> setPasscodeOption(
      String passcode, String option, BuildContext context) async {
    final localAuthContrl = Get.find<LocalAuthController>();

    if (option == 'on') {

      currentPasscodeOption.value = option;
      localAuthContrl.passcode = passcode;
    
      GetIt.I
          .get<LocalStorageSecure>()
          .saveString(KY.KYS.passcodeKey + userID, passcode);
      GetIt.I
          .get<LocalStorageSecure>()
          .saveString(KY.KYS.isPasscode + userID, currentPasscodeOption.value);

    } else {

      currentPasscodeOption.value = option;
      localAuthContrl.passcode = '';

      GetIt.I.get<LocalStorageSecure>().removeData(KY.KYS.passcodeKey + userID);
      GetIt.I
          .get<LocalStorageSecure>()
          .saveString(KY.KYS.isPasscode + userID, currentPasscodeOption.value);

    }
  }

  getBiometricOption() async {
    try {
      currentBiometricOption.value =
        await GetIt.I.get<LocalStorageSecure>().getString(KY.KYS.isBiometric + userID) ??
            'off';

    } catch (e) {
      currentBiometricOption.value = 'off';

    }
  }

  getPasscodeOption() async {
    try {
      currentPasscodeOption.value =
        await GetIt.I.get<LocalStorageSecure>().getString(KY.KYS.isPasscode + userID) ??
            'off';
    } catch (e) {
      currentPasscodeOption.value = 'off';
    }
  }

  void contactEmailFun() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'sgdevelopercompany@gmail.com',
      query: encodeQueryParameters(
          <String, String>{'subject': 'Everbrain App', 'body': 'Hi,'}),
    );

    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    } else {
      throw 'Could not launch ${_emailLaunchUri}';
    }
  }

  void signOutFun(BuildContext context) async{
    final loginContrl = Get.find<LoginController>();
   // var result = await encryContrl.removeKeys();

   //
      try {
        loginContrl.firebaseService.signOut();
      } catch (e) {
        failMessage(context, 'Log out error. Try again in while');
      }
      

  //  }else{

      // ignore: use_build_context_synchronously
      
//}
    
  }

  
}
