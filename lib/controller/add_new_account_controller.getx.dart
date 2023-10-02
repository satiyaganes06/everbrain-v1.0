
import 'package:everbrain/controller/login_controller.getx.dart';
import 'package:everbrain/core/networkService/hms_respository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import '../Model/vault_model.dart';
import '../Model/vault_password_model.dart';
import 'hive_controller.getx.dart';

class AddNewAccountController extends GetxController {
  final loginController = Get.find<LoginController>();

  TextEditingController vaultNameCtrl = TextEditingController();
  TextEditingController vaultUsernameCtrl = TextEditingController();
  TextEditingController vaultPasswordCtrl = TextEditingController();
  TextEditingController vaultWebsiteURLCtrl = TextEditingController();
  String? vaultWebsiteImageUrl = '';
  bool passwordToggle = true;
  bool isFavourite = false;
  bool isBiometricEnable = false;
  var uuid = const Uuid();

  Rx<String> urlCheckResult = 'No threats found'.obs;
  Rx<Color> urlCheckResultColor = colors.AppColor.success.obs;
  Rx<bool> isSubmitBtnEnable = true.obs;


  var category_Selector_List = [false, false, false, false, false, false].obs;
  int current_index = 0;

  List<String> category_Button_Image_Path = [
    'assets/images/entertainment.png',
    'assets/images/medsos.png',
    'assets/images/edtech.png',
    'assets/images/wallet.png',
    'assets/images/shopping.png',
    'assets/images/others.png',
  ];

  List<String> category_Button_Image_title = [
    'Entertainment',
    'Medsos',
    'Edtech',
    'Wallet',
    'Shopping',
    'Others'
  ];


  void funPasswordToggle() {
    passwordToggle = !passwordToggle;
    update();
  }

  void filterToggle(int index) {
    current_index = index;

    switch (index) {
      case 0:
        {
          category_Selector_List.value = [
            true,
            false,
            false,
            false,
            false,
            false
          ];
        }
        break;

      case 1:
        {
          category_Selector_List.value = [
            false,
            true,
            false,
            false,
            false,
            false
          ];
        }
        break;

      case 2:
        {
          category_Selector_List.value = [
            false,
            false,
            true,
            false,
            false,
            false
          ];
        }
        break;

      case 3:
        {
          category_Selector_List.value = [
            false,
            false,
            false,
            true,
            false,
            false
          ];
        }
        break;

      case 4:
        {
          category_Selector_List.value = [
            false,
            false,
            false,
            false,
            true,
            false
          ];
        }
        break;

      case 5:
        {
          category_Selector_List.value = [
            false,
            false,
            false,
            false,
            false,
            true
          ];
        }
        break;
    }
  }

  void favouriteToggle() {
    isFavourite = !isFavourite;
    update();
  }

  void reMpassNeededToggle() {
    isBiometricEnable = !isBiometricEnable;
    update();
  }

  Vault getVaultObject(String uuid) {
    

    return Vault(
        userID: loginController.firebaseService.currentUser!.uid.toString(),
        vaultID: uuid,
        vaultName: vaultNameCtrl.text.toString(),
        websiteUrl: vaultWebsiteURLCtrl.text.toString(),
        websiteImageUrl: vaultWebsiteImageUrl.toString() ,
        username: vaultUsernameCtrl.text,
        vaultCategory: category_Button_Image_title[current_index].toString(),
        isFavourite: isFavourite,
        isBiometricUnlock: isBiometricEnable);
  }

  VaultPassword getVaultPassObject(String uuid) {
    return VaultPassword( 
      valuePasswordKYS: uuid.toString(),
      vaultPassword: vaultPasswordCtrl.text
    );
  }

  addAccountFun()async{

    final hiveCtrl = Get.find<HiveController>();

    String id = uuid.v4();

    getVaultObject(id);
    getVaultPassObject(id);

    await hiveCtrl.addVault(getVaultObject(id), getVaultPassObject(id), Get.context!);
  }

  bool isUrl(String input) {
    RegExp urlPattern = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
      caseSensitive: false,
      multiLine: false,
    );

    return urlPattern.hasMatch(input);
  }

  Future<void> checkUrl(String url) async{
    if(url.isNotEmpty){
      await GetIt.I.get<HmsRepository>().urlCheck(url).then((result) {
        if(result.length >0){
          urlCheckResultColor.value = colors.AppColor.fail;
          urlCheckResult.value = '${result.length} threat is detected for the URL: $url';
          isSubmitBtnEnable.value = false;
        }else{
          urlCheckResultColor.value = colors.AppColor.success;
          urlCheckResult.value = 'No threats found';
          isSubmitBtnEnable.value = true;
        }
      });
    }else{
      urlCheckResultColor.value = colors.AppColor.success;
      urlCheckResult.value = 'No threats found';
      isSubmitBtnEnable.value = true;
    }
  }


  @override
  void onInit() {
    
    super.onInit();
  }

  @override
  void dispose() {
    GetIt.I.get<HmsRepository>().shutdownUrlCheck();
    super.dispose();
  }
}
