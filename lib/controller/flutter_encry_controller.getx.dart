
import 'package:everbrain/Model/vault_password_model.dart';
import 'package:everbrain/controller/edit_account_controller.getx.dart';
import 'package:everbrain/controller/local_auth_controller.getx.dart';
import 'package:everbrain/presentation/Screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../Model/vault_model.dart';
import '../core/localServices/local_auth.dart';
import '../presentation/Screens/dashboard/dashboard_Screen.dart';
import '../presentation/Screens/accountOpt/editAccount/edit_account_screen.dart';
import '../core/localServices/secure_storage_repository.dart';
import '../presentation/widget/global_widget.dart';
import 'dashboard_controller.getx.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/keys.dart' as KY;
import 'hive_controller.getx.dart';
import 'login_controller.getx.dart';

class FlutterEncryController extends GetxController{

  //Operation Values
  static const  _optEdit = KY.KYS.optEdit;
  static const _optPass = KY.KYS.optPass;
  static const _optDelete = KY.KYS.optDelete;
  static const _optCopy = KY.KYS.optCopy;
  static const _optUnlock = KY.KYS.optUnlock;

  Future<LocalStorageResult> userEmailStore(String email, String userID) async{
    var result;

    try {
      var result = await GetIt.I.get<LocalStorageSecure>().saveString(
        KY.KYS.emailKey + userID, email
      );

      debugPrint(result.toString());

      return result;

    } catch (e) {

      debugPrint(e.toString());

      return result;
    }
  }

  Future<LocalStorageResult> masterPassStore(String pass, String userID) async{
    var result;

    try {
      var result = await GetIt.I.get<LocalStorageSecure>().saveString(
        KY.KYS.masterPasswordKey + userID, pass
      );

      debugPrint(result.toString());

      return result;

    } catch (e) {

      debugPrint(e.toString());

      return result;
    }
  }

  Future<LocalStorageResult> currentUSerEmailVerified(String value) async{
    var result;

    try {
      var result = await GetIt.I.get<LocalStorageSecure>().saveString(
        'emailVerifiedValue', value 
      );

      debugPrint(result.toString());

      return result;

    } catch (e) {

      debugPrint(e.toString());

      return result;
    }
  }

  Future<LocalStorageResult> masterPassClear(String userID) async{
    var result;

    try {
      var result = await GetIt.I.get<LocalStorageSecure>().removeData(KY.KYS.masterPasswordKey + userID);

      debugPrint(result.toString());

      return result;

    } catch (e) {

      debugPrint(e.toString());
      
      return result;
    }
  }

  Future<LocalStorageResult> userIDClear() async{
    var result;

    try {
      var result = await GetIt.I.get<LocalStorageSecure>().removeData('userID');

      debugPrint(result.toString());

      return result;

    } catch (e) {

      debugPrint(e.toString());
      
      return result;
    }
  }

  Future<LocalStorageResult> removeKeys() async{
    final loginCon = Get.find<LoginController>();

    try {
      var resultBio = await GetIt.I.get<LocalStorageSecure>().removeData(KY.KYS.isBiometric);
      var resultIsPass =  await GetIt.I.get<LocalStorageSecure>().removeData(KY.KYS.isPasscode);
      var resultPass =  await GetIt.I.get<LocalStorageSecure>().removeData(KY.KYS.passcodeKey);
      var resultMasterPass = await GetIt.I.get<LocalStorageSecure>().removeData(loginCon.firebaseService.currentUser!.uid.toString());

      if(resultBio == LocalStorageResult.deleted && resultIsPass == LocalStorageResult.deleted && resultPass == LocalStorageResult.deleted && resultMasterPass == LocalStorageResult.deleted){
        return LocalStorageResult.deleted;
      }else{
        return LocalStorageResult.failed;
      }

    } catch (e) {

      return LocalStorageResult.failed;
    }
  }

  void validateMasterPass(String value, BuildContext context, int optValue, {Vault? vault}) async{
    final loginCon = Get.find<LoginController>();
    
    final master =
        await GetIt.I.get<LocalStorageSecure>().getString(KY.KYS.masterPasswordKey + loginCon.firebaseService.currentUser!.uid.toString());

    if(value == master){


      switch (optValue) {
        case _optUnlock:
          Get.find<LocalAuthController>().isUnlock.value = true;
          await Future.delayed(const Duration(seconds: 1)); 
          Get.off(() => const MainScreen());
          Get.find<LocalAuthController>().passcodeController.clear();
          await Future.delayed(const Duration(seconds: 1)); 
          Get.find<LocalAuthController>().isUnlock.value = false;
          break;

        case _optCopy:

          final editAccCon = Get.find<EditAccountController>();
          // ignore: use_build_context_synchronously
           editAccCon.funPasswordCopy(context);
          break;

        case _optPass:

          final editAccCon = Get.find<EditAccountController>();
          editAccCon.funPasswordViewToggle();
          break;

        case _optEdit:
          Get.to(() => EditAccountScreen(vault: vault ?? Vault(
              userID: '',
            vaultID: '',
            vaultName: '',
            websiteImageUrl: '',
            username: '',
            vaultCategory: '',
            isFavourite: false,
            isBiometricUnlock: false, 
            websiteUrl: '')));
          break;

        case _optDelete:
          final hiveCtrl = Get.find<HiveController>();
          final editAccCon = Get.find<EditAccountController>();
          // ignore: use_build_context_synchronously
          hiveCtrl.deleteVault(
            editAccCon.updatedVaultInfo(vault ?? Vault(
              userID: '',
            vaultID: '',
            vaultName: '',
            websiteImageUrl: '',
            username: '',
            vaultCategory: '',
            isFavourite: false,
            isBiometricUnlock: false, 
            websiteUrl: '')),
            context
          );
          Get.offAll(const MainScreen());
          break;
        default:
      } 
      
    }else{

      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: const Text('Master password is not matching'),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void validatePasscode(String value) async{
    if(Get.find<LocalAuthController>().passcode == value){     
      Get.find<LocalAuthController>().isUnlock.value = true;
      await Future.delayed(const Duration(seconds: 1)); 
      Get.off(() => const MainScreen());
      Get.find<LocalAuthController>().passcodeController.clear();
      await Future.delayed(const Duration(seconds: 1)); 
      Get.find<LocalAuthController>().isUnlock.value = false;
    }
  }

  void biometricUnlock({required int optValue, required String title, required BuildContext context, Vault? vault}) async{
    final isAuthenticated = await LocalAuth.authenticate("Scan to $title");
    if(isAuthenticated){

      switch (optValue) {
        case _optUnlock:
          Get.find<LocalAuthController>().isUnlock.value = true;
          await Future.delayed(const Duration(seconds: 1)); 
          Get.off(() => const MainScreen());
          Get.find<LocalAuthController>().passcodeController.clear();
          await Future.delayed(const Duration(seconds: 1)); 
          Get.find<LocalAuthController>().isUnlock.value = false;
          break;
        case _optCopy:
          final editAccCon = Get.find<EditAccountController>();
          // ignore: use_build_context_synchronously
          editAccCon.funPasswordCopy(context);
          break;

        case _optPass:
          print('here');
          final editAccCon = Get.find<EditAccountController>();
          editAccCon.funPasswordViewToggle() ;
          
          break;

        case _optEdit:
        Get.to(() => EditAccountScreen(vault: vault ?? Vault(
              userID: '',
            vaultID: '',
            vaultName: '',
            websiteImageUrl: '',
            username: '',
            vaultCategory: '',
            isFavourite: false,
            isBiometricUnlock: false, 
            websiteUrl: '')));
          break;

        case _optDelete:
          final hiveCtrl = Get.find<HiveController>();
          final editAccCon = Get.find<EditAccountController>();
          // ignore: use_build_context_synchronously
          hiveCtrl.deleteVault(
            editAccCon.updatedVaultInfo(vault ?? Vault(
              userID: '',
            vaultID: '',
            vaultName: '',
            websiteImageUrl: '',
            username: '',
            vaultCategory: '',
            isFavourite: false,
            isBiometricUnlock: false, 
            websiteUrl: '')),
            context
          );

          hiveCtrl.deleteVaultPass(vault!.vaultID, context);
          Get.offAll(const MainScreen());
          break;
        default:
      } 
      
    }
  }
  
  
}