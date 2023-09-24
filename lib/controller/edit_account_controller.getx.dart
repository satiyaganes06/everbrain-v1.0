import 'package:everbrain/Model/vault_model.dart';
import 'package:everbrain/controller/hive_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;

import '../Model/vault_password_model.dart';
import '../core/localServices/local_auth.dart';

class EditAccountController extends GetxController {
  //View
  TextEditingController vaultNameCtrl = TextEditingController();
  TextEditingController vaultUsernameCtrl = TextEditingController();
  TextEditingController vaultPasswordCtrl = TextEditingController();
  TextEditingController vaultWebsiteURLCtrl = TextEditingController();

  //Edit
  TextEditingController vaultNameEditCtrl = TextEditingController();
  TextEditingController vaultUsernameEditCtrl = TextEditingController();
  TextEditingController vaultPasswordEditCtrl = TextEditingController();
  TextEditingController vaultWebsiteURLEditCtrl = TextEditingController();

  String? vaultWebsiteImageUrl = '';
  bool _passwordViewToggle = true;
  bool _passwordEditToggle = true;
  bool isFavourite = false;
  bool isBiometricEnable = false;

  bool get getPassViewToggle => _passwordViewToggle;
  bool get getPassEditToggle => _passwordEditToggle;

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

  void funPasswordViewToggle() {
    _passwordViewToggle = !_passwordViewToggle;
    update();
  }

  void funPasswordEditToggle() {
    _passwordEditToggle = !_passwordEditToggle;
    update();
  }

  void makePassTrue() {
    _passwordEditToggle = true;
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

  void isBiometricNeededToggle() {
    isBiometricEnable = !isBiometricEnable;
    update();
  }

  void funPasswordCopy(BuildContext context, {String? password}) {
    Clipboard.setData(ClipboardData(text: password ?? vaultPasswordCtrl.text))
        .then((value) {
      //only if ->
      Get.snackbar(
        'Password Copied',
        'Password copied to clipboard',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: colors.AppColor.accentColor,
        colorText: colors.AppColor.secondaryColor,
        icon: Icon(
          Icons.check_circle_outline_rounded,
          color: colors.AppColor.secondaryColor,
        ),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      );
    });
  }

  void editSetup(Vault vault) async {
    vaultNameEditCtrl.text = vault.vaultName;
    vaultUsernameEditCtrl.text = vault.username;
    vaultPasswordEditCtrl.text =
        await Get.find<HiveController>().getVaultPassword(vault.vaultID);
    vaultWebsiteURLEditCtrl.text = vault.websiteUrl;
    vaultWebsiteImageUrl = vault.websiteImageUrl;
    isFavourite = vault.isFavourite;
    isBiometricEnable = vault.isBiometricUnlock;
    update();
    filterToggle(category_Button_Image_title.indexOf(vault.vaultCategory));
  }

  Vault updatedVaultInfo(Vault vault) {
    return vault.copyWith(
        vaultName: vaultNameEditCtrl.text,
        websiteImageUrl: vaultWebsiteImageUrl,
        username: vaultUsernameEditCtrl.text,
        websiteUrl: vaultWebsiteURLEditCtrl.text,
        vaultCategory: category_Button_Image_title[current_index].toString(),
        isFavourite: isFavourite,
        isBiometricUnlock: isBiometricEnable);
  }

  @override
  void dispose() {
    vaultNameCtrl.dispose();
    vaultUsernameCtrl.dispose();
    vaultPasswordCtrl.dispose();
    vaultWebsiteURLCtrl.dispose();
    vaultNameEditCtrl.dispose();
    vaultUsernameEditCtrl.dispose();
    vaultPasswordEditCtrl.dispose();
    vaultWebsiteURLEditCtrl.dispose();

    super.dispose();
  }
}
