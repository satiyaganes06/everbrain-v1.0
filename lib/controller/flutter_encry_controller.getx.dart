
import 'package:everbrain/controller/edit_account_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../Model/vault_model.dart';
import '../core/localServices/local_auth.dart';
import '../presentation/Screens/dashboard/dashboard_Screen.dart';
import '../presentation/Screens/accountOpt/editAccount/edit_account_screen.dart';
import '../core/localServices/secure_storage_repository.dart';
import 'dashboard_controller.getx.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/keys.dart' as KY;
import 'login_controller.getx.dart';

class FlutterEncryController extends GetxController{

  //Operation Values
  static const  _optEdit = KY.KYS.optEdit;
  static const _optPass = KY.KYS.optPass;
  static const _optDelete = KY.KYS.optDelete;
  static const _optCopy = KY.KYS.optCopy;


  Future<LocalStorageResult> masterPassStore(String pass, String userID) async{
    var result;

    try {
      var result = await GetIt.I.get<LocalStorageSecure>().saveString(
        userID, pass
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
      var result = await GetIt.I.get<LocalStorageSecure>().removeData(userID);

      debugPrint(result.toString());

      return result;

    } catch (e) {

      debugPrint(e.toString());
      
      return result;
    }
  }

  void validateMasterPass(String value, BuildContext context, int optValue, {Vault? vault}) async{
    final loginCon = Get.find<LoginController>();
    final editAccCon = Get.find<EditAccountController>();
    
    final master =
        await GetIt.I.get<LocalStorageSecure>().getString(loginCon.firebaseService.currentUser!.uid.toString());

    if(value == master){

      switch (optValue) {
        case _optCopy:
          // ignore: use_build_context_synchronously
          editAccCon.funPasswordCopy(vault!.vaultPassword, context);
          break;

        case _optPass:
          editAccCon.funPasswordToggle();
          break;

        case _optEdit:
          Get.to(EditAccountScreen(vault: vault ?? Vault(
            userID: '',
            vaultID: '',
            sourceName: '',
            sourceImageUrl: '',
            vaultName: '',
            vaultPassword: '',
            hintPassword: '',
            vaultCategory: '',
            isFavourite: false,
            isMPUnlock: false)));
          break;

        case _optDelete:
          final dashboardController = Get.find<DashboardController>();
        
          // ignore: use_build_context_synchronously
          dashboardController.deleteVault(
            editAccCon.updateCopyWith(vault ?? Vault(
            userID: '',
            vaultID: '',
            sourceName: '',
            sourceImageUrl: '',
            vaultName: '',
            vaultPassword: '',
            hintPassword: '',
            vaultCategory: '',
            isFavourite: false,
            isMPUnlock: false)),
            context
          );
          Get.offAll(const DashboardScreen());
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

  void biometricUnlock({required int optValue, required String title ,required BuildContext context, Vault? vault}) async{
    final isAuthenticated = await LocalAuth.authenticate("Scan to $title");
    final editAccCon = Get.find<EditAccountController>();

    if(isAuthenticated){

      switch (optValue) {
        case _optCopy:
          // ignore: use_build_context_synchronously
          editAccCon.funPasswordCopy(vault!.vaultPassword, context);
          break;

        case _optPass:
          editAccCon.funPasswordToggle();
          break;

        case _optEdit:
          Get.to(EditAccountScreen(vault: vault ?? Vault(
            userID: '',
            vaultID: '',
            sourceName: '',
            sourceImageUrl: '',
            vaultName: '',
            vaultPassword: '',
            hintPassword: '',
            vaultCategory: '',
            isFavourite: false,
            isMPUnlock: false)));
          break;

        case _optDelete:
          final dashboardController = Get.find<DashboardController>();
        
          // ignore: use_build_context_synchronously
          dashboardController.deleteVault(
            editAccCon.updateCopyWith(vault ?? Vault(
            userID: '',
            vaultID: '',
            sourceName: '',
            sourceImageUrl: '',
            vaultName: '',
            vaultPassword: '',
            hintPassword: '',
            vaultCategory: '',
            isFavourite: false,
            isMPUnlock: false)),
            context
          );
          Get.offAll(const DashboardScreen());
          break;
        default:
      } 
      
    }
  }
  
}