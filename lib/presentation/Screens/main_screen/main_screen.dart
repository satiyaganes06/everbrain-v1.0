
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/presentation/Screens/dashboard/dashboard_Screen.dart';
import 'package:everbrain/presentation/Screens/passwordGenerator/password_generator_screen.dart';
import 'package:everbrain/presentation/Screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/b_navigator_controller.getx.dart';

class MainScreen extends StatelessWidget  {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
  Get.lazyPut(() => NavigatorController());
    

    return Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, Get.find<NavigatorController>()),
      body: Obx(() => IndexedStack(
        index: Get.find<NavigatorController>().currentIndex.value,
        children: const [
          DashboardScreen(),
          PasswordGeneratorScreen(),
          SettingScreen()
        ],
      )),
    );
  }

  buildBottomNavigationMenu(context, navi) {
    return  Obx(() => DotNavigationBar(
            currentIndex: navi.currentIndex.value,
            onTap: navi.changeTabIndex,
            enableFloatingNavBar:true,
            backgroundColor: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colors.AppColor.accentColor.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
            marginR : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            paddingR: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            borderRadius :  0,  
            items: [
              //Basic Sliver Bar
              DotNavigationBarItem(
                icon: const Icon(Icons.lock_outline_rounded),
               // icon: SvgPicture.asset("assets/icons/menu-scale.svg", color: colors.AppColor.accentColor, width: 20, height: 20,),
                selectedColor: colors.AppColor.primaryColor,
                unselectedColor: colors.AppColor.tertiaryColor,
              ),
              
              //Tabbar Sliver bar
              DotNavigationBarItem(
                icon: const Icon(Icons.password_rounded),
                selectedColor: colors.AppColor.primaryColor,
                unselectedColor: colors.AppColor.tertiaryColor,
              ),
                //Advanced Sliver bar
              DotNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                selectedColor: colors.AppColor.primaryColor,
                unselectedColor: colors.AppColor.tertiaryColor,
              ),
            ],
            ));
      
       
    
    
  }
}