import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:uuid/uuid.dart';

import 'login_controller.dart';
import '../Model/vault_model.dart';

class AddNewAccountController extends GetxController {
  final loginController = Get.find<LoginController>();

  TextEditingController searchCompanyName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController emailRusernameRphone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController hintPassword = TextEditingController();
  bool passwordToggle = true;
  bool isFavourite = false;
  bool isReMpassNeeded = false;

  int animationDuration = 100;

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
    isReMpassNeeded = !isReMpassNeeded;
    update();
  }

  Vault getVaultObject() {
    var uuid = const Uuid();

    return Vault(
        userID: loginController.firebaseService.currentUser!.uid.toString(),
        vaultID: uuid.v4(),
        sourceName: companyName.text.toString(),
        sourceImageUrl: isUrl(searchCompanyName.text.toString()) ? searchCompanyName.text.toString() : 'https://www.usbforwindows.com/storage/img/images_3/function_set_default_image_when_image_not_present.png' ,
        vaultName: emailRusernameRphone.text,
        vaultPassword: password.text,
        hintPassword: hintPassword.text,
        vaultCategory: category_Button_Image_title[current_index].toString(),
        isFavourite: isFavourite,
        isMPUnlock: isReMpassNeeded);
  }

  bool isUrl(String input) {
    RegExp urlPattern = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
      caseSensitive: false,
      multiLine: false,
    );

    return urlPattern.hasMatch(input);
  }
}
