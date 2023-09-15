
import 'package:everbrain/core/localServices/local_auth.dart';
import 'package:everbrain/presentation/Widget/global_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:everbrain/utils/keys.dart' as KY;
import '../core/localServices/secure_storage_repository.dart';

class SettingController extends GetxController{
  List<String> settingOption = ['off', 'on'];

  String currentBiometricOption = 'off';

  void setBiometricOption(String option, BuildContext context) async{
    
    if(option == 'on'){
      if(await LocalAuth.hasBiometrics()){
        currentBiometricOption = option;
        update(['biometric']);

        GetIt.I.get<LocalStorageSecure>().saveString(KY.KYS.isBiometric, currentBiometricOption);

        Navigator.pop(context);
        
      }else{
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        failMessage(context, 'Your device does not support biometric authentication');
      }
    }else{
      currentBiometricOption = option;
      update(['biometric']);

      GetIt.I.get<LocalStorageSecure>().saveString(KY.KYS.isBiometric, currentBiometricOption);

      Navigator.pop(context);
    }

  }

  @override
  void onInit() async{
    currentBiometricOption = await GetIt.I.get<LocalStorageSecure>().getString(KY.KYS.isBiometric) ?? 'off';
    update(['biometric']);
    super.onInit();
  }
}