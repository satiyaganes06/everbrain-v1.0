
import 'package:everbrain/Model/vault_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;

import '../core/localServices/local_auth.dart';

class EditAccountController extends GetxController{
  TextEditingController searchCompanyName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController emailRusernameRphone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController hintPassword = TextEditingController();
  bool _passwordToggle = true;
  bool isFavourite = false;
  bool isReMpassNeeded = false;
  int animationDuration = 100;

  bool get getPassToggle => _passwordToggle;

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
    _passwordToggle = !_passwordToggle;
    update();
  }

  void makePassTrue(){
    _passwordToggle = true;
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
    isReMpassNeeded = !isReMpassNeeded;
    update();
  }

  void funPasswordCopy(String password, BuildContext context) {
    Clipboard.setData(ClipboardData(text: password))
    .then((value) { //only if ->
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Copied"),
        backgroundColor: colors.AppColor.tertiaryColor,
        duration: const Duration(seconds: 1),
      ));});
    
  }

  void editSetup(Vault vault) {
    searchCompanyName.text = vault.sourceImageUrl;
    companyName.text  = vault.sourceName;
    emailRusernameRphone.text  = vault.vaultName;
    password.text  = vault.vaultPassword;
    hintPassword.text  = vault.hintPassword;
    isFavourite = vault.isFavourite;
    isReMpassNeeded = vault.isMPUnlock;
    filterToggle(category_Button_Image_title.indexOf(vault.vaultCategory));
  }

  Vault updateCopyWith(Vault vault){
    return vault.copyWith(
        sourceName: companyName.text,
        sourceImageUrl: searchCompanyName.text,
        vaultName: emailRusernameRphone.text,
        vaultPassword: password.text,
        hintPassword: hintPassword.text,
        vaultCategory: category_Button_Image_title[current_index].toString(),
        isFavourite: isFavourite,
        isMPUnlock: isReMpassNeeded
      );
  }

}