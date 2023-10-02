
import 'package:everbrain/controller/add_new_account_controller.getx.dart';
import 'package:everbrain/controller/edit_account_controller.getx.dart';
import 'package:everbrain/presentation/Screens/main_screen/main_screen.dart';
import 'package:everbrain/presentation/widget/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import '../Model/vault_model.dart';
import '../Model/vault_password_model.dart';
import '../core/localServices/hive_vault_pass_service.dart';
import '../presentation/Screens/dashboard/dashboard_Screen.dart';
import '../core/localServices/hive_vault_service.dart';

class HiveController extends GetxController{
  RxList<Vault> vaultList = <Vault>[].obs;
  final HiveVaultService _hiveVaultService = HiveVaultService();
  final HiveVaultPassService _hiveVaultPassService = HiveVaultPassService();
  Rx<bool> isLoading = false.obs;

  Future<void> addVault(Vault vaultItem, VaultPassword vaultPassItem, BuildContext context) async{
    try {
      final addAccContrl = Get.find<AddNewAccountController>();
      vaultList.add(vaultItem);
      //update(['list_of_vault']);
    // var vault_Box = await Hive.openBox(vAULTBOXNAME);
      _hiveVaultService.addVault(vault: vaultItem);
      _hiveVaultPassService.addVaultPassword(vaultPass: vaultPassItem);

      addAccContrl.vaultNameCtrl.clear();
      addAccContrl.vaultUsernameCtrl.clear();
      addAccContrl.vaultPasswordCtrl.clear();
      addAccContrl.vaultWebsiteURLCtrl.clear();
      addAccContrl.vaultWebsiteImageUrl = '';
      addAccContrl.passwordToggle = true;
      addAccContrl.isBiometricEnable = false;
      addAccContrl.current_index = 0;
      addAccContrl.isFavourite = false;

    
      successMessage(context, "Locked into Vault");
    
    
    }catch (e) {
      
      failMessage(context, e.toString());
    }
  }

  Future<void> updateVault(Vault vaultItem, BuildContext context) async{
    final _editScreenController = Get.find<EditAccountController>();

    try {
      _hiveVaultService.updateVault(vault: _editScreenController.updatedVaultInfo(vaultItem));
      getListVault();
      //update(['list_of_vault']);
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Successfully update"),
        backgroundColor: colors.AppColor.success,
        duration: const Duration(seconds: 1),
      ));

      Get.offAll(const MainScreen());
    
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<void> updateVaultPassword(String vaultKey, String vaultPassword, BuildContext context) async{

    try {
      await _hiveVaultPassService.updateVaultPass(valuePasswordKYS: vaultKey, vaultPass: vaultPassword);
      
    
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<void> getListVault() async {
    isLoading.value = true;
    vaultList.value =  await _hiveVaultService.getVaultList();
    isLoading.value = false;
    // vaultList.sort((a, b) {
    //   if (a.isFavourite && !b.isFavourite) {
    //     return -1;
    //   } else if (!a.isFavourite && b.isFavourite) {
    //     return 1; 
    //   } else {
    //     return 0; 
    //   }
    // });

  }
  
  searchListVault(String value) async{
    if(value != ''){
      await getListVault();
      vaultList.value = vaultList.value.where((vault) => vault.vaultName.toLowerCase().contains(value.toLowerCase())).toList();
     // update(['list_of_vault']);
    }else{
      getListVault();
    }
  }

  filterList(String value) async{

    if(value == 'favourite'){
      await getListVault();
      vaultList.value = vaultList.value.where((vault) => vault.isFavourite == true).toList();
      
    }
    else if(value != 'All'){
      await getListVault();
      vaultList.value = vaultList.value.where((vault) => vault.vaultCategory == value).toList();
    //  update(['list_of_vault']);
    }else{
      getListVault();
    }
  }

  Future<void>deleteVault(Vault vaultItem, BuildContext context) async {

    try {
      _hiveVaultService.deleteVault(vault: vaultItem);
      getListVault();
      //update(['list_of_vault']);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Remove from Vault"),
        backgroundColor: colors.AppColor.success,
        duration: const Duration(seconds: 2),
      ));
    
    
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
    
    
  }

  Future<String> getVaultPassword(String id) async {
    
    try {
      VaultPassword? vaultPass =  await _hiveVaultPassService.getVaultPass(id:id);
    
      if(vaultPass == null){
       // failMessage(context, 'Something went wrong');
        return '';
      }else{
        return vaultPass.vaultPassword;
      }
    } catch (e) {
     /// failMessage(context, e.toString());
      return '';
    }
  
  }

  Future<void>deleteVaultPass(String vaultPasswordKYS, BuildContext context) async {
    try {
      _hiveVaultPassService.deleteVaultPass(vaultPasswordKYS: vaultPasswordKYS);

  
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
  }

}