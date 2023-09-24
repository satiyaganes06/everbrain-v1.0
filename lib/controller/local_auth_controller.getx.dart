
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/keys.dart' as KY;
import 'package:get_it/get_it.dart';
import '../core/localServices/secure_storage_repository.dart';
import 'login_controller.getx.dart';

class LocalAuthController extends GetxController{
  String passcode = '';
  String userID = '';

  Rx<bool> isUnlock = false.obs;
  final passcodeController = TextEditingController();

  @override
  onInit() async{
    await getPasscode();
    super.onInit();
  }

  getPasscode() async {
   try {
      userID = await GetIt.I.get<LocalStorageSecure>().getString('userID') ?? '';
      passcode = await GetIt.I.get<LocalStorageSecure>().getString(KY.KYS.passcodeKey + userID) ?? '';
   } catch (e) {
      passcode = '';
   }
  }

  @override
  void dispose() {
    passcodeController.dispose();
    super.dispose();
  }

}