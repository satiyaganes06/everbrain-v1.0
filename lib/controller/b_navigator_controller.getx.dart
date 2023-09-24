import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';


class NavigatorController extends GetxController{

  var advancedDrawerController ;

  var currentIndex = 0.obs;
  var isHide = false.obs;

  @override
  onInit(){
    super.onInit();
    advancedDrawerController = AdvancedDrawerController();
  }

  
  changeTabIndex(int index){
    currentIndex.value = index;
  }

  hideBottomBar(isHide){
    isHide.value = !isHide.value;
  }

   void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

 
  

}