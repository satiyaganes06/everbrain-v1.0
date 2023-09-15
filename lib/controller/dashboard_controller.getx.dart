import 'package:auto_animated/auto_animated.dart';
import 'package:everbrain/controller/add_new_account_controller.getx.dart';
import 'package:everbrain/controller/edit_account_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import '../Model/vault_model.dart';
import '../presentation/Screens/dashboard/dashboard_Screen.dart';
import '../core/localServices/hive_service.dart';

class DashboardController extends GetxController{
  //For Grid
  final options = const LiveOptions(
      showItemInterval: Duration(milliseconds: 200),

      showItemDuration: Duration(milliseconds: 200),

      visibleFraction: 0.05,

      reAnimateOnVisibility: false,
  );

  List<Vault> vaultList = [];
  final HiveService _hiveService = HiveService();
  
  //For list
  final scrollController = ScrollController();
  RxBool isScroll = false.obs;
  final listShowItemDuration = const Duration(milliseconds: 200);

  var category_Selector_List = [true, false, false, false, false, false, false].obs;
  int current_index = 0;
  
  // ignore: non_constant_identifier_names
  List<String> category_Button_Image_Path = [
    'assets/images/all.png',
    'assets/images/entertainment.png',
    'assets/images/medsos.png',
    'assets/images/edtech.png',
    'assets/images/wallet.png',
    'assets/images/shopping.png',
    'assets/images/others.png',
  ];

  List<String> category_Button_Image_title = [
    'All',
    'Entertainment',
    'Medsos',
    'Edtech',
    'Wallet',
    'Shopping',
    'Others'
  ];

  void colorChange(int index){
    
    current_index = index;

    switch(index) { 
      case 0: {  
        category_Selector_List.value = [true, false, false, false, false, false, false];
        filterList(category_Button_Image_title[index]);
      } 
      break; 
     
      case 1: {  
        category_Selector_List.value = [false, true, false, false, false, false, false];
        filterList(category_Button_Image_title[index]);
      } 
      break; 
     
      case 2: {  
        category_Selector_List.value = [false, false, true, false, false, false, false];
        filterList(category_Button_Image_title[index]);
 
      } 
      break; 
     
      case 3: {  
        category_Selector_List.value = [false, false, false, true, false, false, false];
        filterList(category_Button_Image_title[index]);
      } 
      break; 

      case 4: {  
        category_Selector_List.value = [false, false, false, false, true, false, false];
        filterList(category_Button_Image_title[index]);
      } 
      break; 

      case 5: {  
        category_Selector_List.value = [false, false, false, false, false, true, false];
        filterList(category_Button_Image_title[index]);
      } 
      break; 

      case 6: {  
        category_Selector_List.value = [false, false, false, false, false, false, true];
        filterList(category_Button_Image_title[index]);
      } 
      break; 

   } 
  
  }
  
  bool scrollingCheck(var notification){
    if(notification == ScrollDirection.forward){
      isScroll.value = true;

    }else if(notification == ScrollDirection.reverse){
      isScroll.value = false;

    }
    return isScroll.value;
  }

  @override
  void onInit(){
    super.onInit();
    getListVault();
  }

  //   Box box;
  //   try {
  //     _hiveService.openBox();
  //   } catch (e) {
  //     box = await Hive.openBox(_hiveService.bOxName);
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(e.toString()),
  //       backgroundColor: colors.AppColor.fail,
  //       duration: const Duration(seconds: 10),
  //     ));
  //   }
  //  // var items = box.get('cart_items');
  //   return items as List<Vault>;
  // }

  Future<void> addVault(Vault vaultItem, BuildContext context) async{
    try {
      final addAccContrl = Get.find<AddNewAccountController>();
      vaultList.add(vaultItem);
      update(['list_of_vault']);
    // var vault_Box = await Hive.openBox(vAULTBOXNAME);
      _hiveService.addVault(vault: vaultItem);

      addAccContrl.searchCompanyName.clear();
      addAccContrl.companyName.clear();
      addAccContrl.emailRusernameRphone.clear();
      addAccContrl.password.clear();
      addAccContrl.hintPassword.clear();
      addAccContrl.current_index = 0;
      addAccContrl.isFavourite = false;
      addAccContrl.isReMpassNeeded = false;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Locked into Vault"),
        backgroundColor: colors.AppColor.success,
        duration: const Duration(seconds: 1),
      ));
    
    
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<void> updateVault(Vault vaultItem, BuildContext context) async{
    final _editScreenController = Get.find<EditAccountController>();

    try {
      _hiveService.updateVault(vault: _editScreenController.updateCopyWith(vaultItem));
      getListVault();
      update(['list_of_vault']);
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Successfully update"),
        backgroundColor: colors.AppColor.success,
        duration: const Duration(seconds: 1),
      ));

      Get.offAll(const DashboardScreen());
    
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<void> getListVault() async {
    vaultList =  await _hiveService.getVaultList();
    vaultList.sort((a, b) {
    if (a.isFavourite && !b.isFavourite) {
      return -1;
    } else if (!a.isFavourite && b.isFavourite) {
      return 1; 
    } else {
      return 0; 
    }
  });
    update(['list_of_vault']);
  }

  filterList(String value) async{
    if(value != 'All'){
      await getListVault();
      vaultList = vaultList.where((vault) => vault.vaultCategory == value).toList();
      update(['list_of_vault']);
    }else{
      getListVault();
    }
  }

  Future<void>deleteVault(Vault vaultItem, BuildContext context) async {

    try {
      _hiveService.deleteVault(vault: vaultItem);
      getListVault();
      update(['list_of_vault']);

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

}