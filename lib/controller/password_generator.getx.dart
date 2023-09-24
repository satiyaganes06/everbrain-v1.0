import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import '../core/localServices/password_generator_service.dart';

class PasswordGenerator extends GetxController {
  Rx<double> characterLength = 4.0.obs;
  Rx<double> passwordStrength = 4.0.obs;
  Rx<String> passwordStrengthText = 'Weak'.obs;
  Rx<Color> passwordStrengthColor = colors.AppColor.fail2.obs;
  Rx<String> timeOfCrack = '16 minutes'.obs;
  GeneratePassword generatePassword = GeneratePassword();
  Rx<String> generatedPassword = ''.obs;

  Rx<bool> isUpperCase = true.obs;
  Rx<bool> isLowerCase = true.obs;
  Rx<bool> isNumbers = true.obs;
  Rx<bool> isSymbols = true.obs;
  int isValues = 4;

  @override
  void onInit() {
    _generatePasswordFunc(
        length: characterLength.round(),
        uppercase: true,
        lowercase: true,
        numbers: true,
        symbols: true);
    super.onInit();
  }

  void updatePasswordFun(double value) {
    characterLength.value = value;
    _generatePasswordFunc(
        length: value.round(),
        uppercase: isUpperCase.value,
        lowercase: isLowerCase.value,
        numbers: isNumbers.value,
        symbols: isSymbols.value);
  }

  void _generatePasswordFunc(
      {required length,
      required bool uppercase,
      required bool lowercase,
      required bool numbers,
      required bool symbols}) {
    generatedPassword.value = generatePassword.generatePassword(
        length: length,
        uppercase: uppercase,
        lowercase: lowercase,
        numbers: numbers,
        symbols: symbols);
  }

  void updatePasswordStrength(double value) {
    if (value <= 6.0) {
      passwordStrength.value = 20.0;
      passwordStrengthText.value = 'Weak';
      passwordStrengthColor.value = colors.AppColor.fail2;
    } else if (value <= 10.0) {
      passwordStrength.value = 40.0;
      passwordStrengthText.value = 'Medium';
      passwordStrengthColor.value = colors.AppColor.medium;
    } else if (value <= 14.0) {
      passwordStrength.value = 60.0;
      passwordStrengthText.value = 'Strong';
      passwordStrengthColor.value = colors.AppColor.success;
    } else if (value <= 15.0) {
      passwordStrength.value = 80.0;
      passwordStrengthText.value = 'Very Strong';
      passwordStrengthColor.value = colors.AppColor.success;
    } else if (value >= 20.0) {
      passwordStrength.value = 100.0;
      passwordStrengthText.value = 'Unbreakable';
      passwordStrengthColor.value = colors.AppColor.success;
    }
    HapticFeedback.heavyImpact();
    passwordStrengthTextFun(value);
  }

  void passwordStrengthTextFun(double valueee) {
    double value = valueee.ceil().toDouble();
    if (value == 4.0) {
      timeOfCrack.value = '16 minutes';
    } else if (value == 5.0) {
      timeOfCrack.value = '2 hours';
    } else if (value == 6.0) {
      timeOfCrack.value = '1 day';
    } else if (value == 7.0) {
      timeOfCrack.value = '11 days';
    } else if (value == 8.0) {
      timeOfCrack.value = '3 months';
    } else if (value == 9.0) {
      timeOfCrack.value = '3 years';
    } else if (value == 10.0) {
      timeOfCrack.value = '35 years';
    } else if (value == 11.0) {
      timeOfCrack.value = '362 years';
    } else if (value == 12.0) {
      timeOfCrack.value = '2 thousand years';
    } else if (value == 13.0) {
      timeOfCrack.value = '24 thousand years';
    } else if (value == 14.0) {
      timeOfCrack.value = '325 thousand years';
    } else if (value == 15.0) {
      timeOfCrack.value = '3 million years';
    } else if (value == 16.0) {
      timeOfCrack.value = '25 million years';
    } else if (value == 17.0) {
      timeOfCrack.value = '253 million years';
    } else if (value == 18.0) {
      timeOfCrack.value = '2567 million years';
    } else if (value == 19.0) {
      timeOfCrack.value = '3896 million years';
    } else {
      timeOfCrack.value =
          'Exceeding the duration of the universe\'s existence.';
    }
  }

  void isLowerCaseToggle() {
    if (isLowerCase.value == true) {
      if (isValues > 1) {
        isValues = isValues - 1;
        isLowerCase.value = !isLowerCase.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    } else {
      if (isValues < 4) {
        isValues = isValues + 1;
        isLowerCase.value = !isLowerCase.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    }
  }

  void isUpperCaseToggle() {
    if (isUpperCase.value == true) {
      if (isValues > 1) {
        isValues = isValues - 1;
        isUpperCase.value = !isUpperCase.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    } else {
      if (isValues < 4) {
        isValues = isValues + 1;
        isUpperCase.value = !isUpperCase.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    }
  }

  void isNumbersToggle() {
    if (isNumbers.value == true) {
      if (isValues > 1) {
        isValues = isValues - 1;
        isNumbers.value = !isNumbers.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    } else {
      if (isValues < 4) {
        isValues = isValues + 1;
        isNumbers.value = !isNumbers.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    }
  }

  void isSymbolsToggle() {
    if (isSymbols.value == true) {
      if (isValues > 1) {
        isValues = isValues - 1;
        isSymbols.value = !isSymbols.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    } else {
      if (isValues < 4) {
        isValues = isValues + 1;
        isSymbols.value = !isSymbols.value;
        _generatePasswordFunc(
            length: characterLength.round(),
            uppercase: isUpperCase.value,
            lowercase: isLowerCase.value,
            numbers: isNumbers.value,
            symbols: isSymbols.value);
      }
    }
  }

  void funPasswordCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: generatedPassword.value))
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
}
