import 'dart:io';
import 'package:everbrain/presentation/Screens/auth/widget_Tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'Model/vault_model.dart';
import 'presentation/Screens/auth/SplashScreen.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'main_module.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
    if(Platform.isAndroid){
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_BLUR_BEHIND);
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_DIM_BEHIND);
    }
  });
  
  MainModule.init();
  await Hive.initFlutter();
  Hive.registerAdapter(VaultAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: colors.AppColor.primaryColor));

    return FutureBuilder(
          future: Init.instance.initialize(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GetMaterialApp(
                defaultTransition: GetPlatform.isAndroid
                    ? Transition.fade
                    : Transition.cupertino,
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
              );
            } else {
              return const GetMaterialApp(
                home: WidgetTree(),
                debugShowCheckedModeBanner: false,
              );
            }
          },
        );
  }
}


class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 2));
  }
}
