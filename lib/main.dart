import 'dart:io';
import 'package:everbrain/presentation/Screens/auth/login/loginScreen.dart';
import 'package:everbrain/presentation/Screens/auth/widget_Tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'Model/vault_model.dart';
import 'Model/vault_password_model.dart';
import 'core/localServices/secure_storage_repository.dart';
import 'core/networkService/firebase_service.dart';
import 'presentation/Screens/auth/SplashScreen.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/keys.dart' as KY;
import 'main_module.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'presentation/Screens/auth/local_auth/local_auth_screen.dart';

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
  Hive.registerAdapter(VaultPasswordAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    if(state == AppLifecycleState.inactive  || state == AppLifecycleState.detached) return;
      
    final isBackground = state == AppLifecycleState.paused;

    if(isBackground) {
      //  try {
  //    String? value = FirebaseService().currentUserID();
  //  print('Value $value');
    Get.offAll(LocalAuthScreen());

  //   if(value != 'null'){
    // var value = await GetIt.I.get<LocalStorageSecure>().getString('emailVerifiedValue');
    // var value2 = FirebaseService().currentUserID2();

    // if(value2!=null){
    //   if(value == true){
      
    //     Get.offAll(LocalAuthScreen());
    
    //   }
    // }else{
    //   Get.offAll(LoginScreen());
    // }

    
  }}

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
                home: const SplashScreen(),
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
