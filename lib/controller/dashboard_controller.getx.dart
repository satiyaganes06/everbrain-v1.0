import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'hive_controller.getx.dart';

class DashboardController extends GetxController{

  final hiveController = Get.put(HiveController());
  //For Grid
  final options = const LiveOptions(
      showItemInterval: Duration(milliseconds: 200),

      showItemDuration: Duration(milliseconds: 200),

      visibleFraction: 0.05,

      reAnimateOnVisibility: false,
  );

  
  //For list
  final scrollController = ScrollController();
  RxBool isScroll = false.obs;
  final listShowItemDuration = const Duration(milliseconds: 200);

  var category_Selector_List = [true, false, false, false, false, false, false].obs;
  int current_index = 0;
  
  // ignore: non_constant_identifier_names
  List<String> category_Button_Image_Path = [
    'assets/images/all.png',
    'assets/images/entertainment.png',
    'assets/images/medsos.png',
    'assets/images/edtech.png',
    'assets/images/wallet.png',
    'assets/images/shopping.png',
    'assets/images/others.png',
  ];

  List<String> category_Button_Image_title = [
    'All',
    'Entertainment',
    'Medsos',
    'Edtech',
    'Wallet',
    'Shopping',
    'Others'
  ];

  void colorChange(int index){
    
    current_index = index;

    switch(index) { 
      case 0: {  
        category_Selector_List.value = [true, false, false, false, false, false, false];
        hiveController.filterList(category_Button_Image_title[index]);
      } 
      break; 
     
      case 1: {  
        category_Selector_List.value = [false, true, false, false, false, false, false];
        hiveController.filterList(category_Button_Image_title[index]);
      } 
      break; 
     
      case 2: {  
        category_Selector_List.value = [false, false, true, false, false, false, false];
        hiveController.filterList(category_Button_Image_title[index]);
 
      } 
      break; 
     
      case 3: {  
        category_Selector_List.value = [false, false, false, true, false, false, false];
        hiveController.filterList(category_Button_Image_title[index]);
      } 
      break; 

      case 4: {  
        category_Selector_List.value = [false, false, false, false, true, false, false];
        hiveController.filterList(category_Button_Image_title[index]);
      } 
      break; 

      case 5: {  
        category_Selector_List.value = [false, false, false, false, false, true, false];
        hiveController.filterList(category_Button_Image_title[index]);
      } 
      break; 

      case 6: {  
        category_Selector_List.value = [false, false, false, false, false, false, true];
        hiveController.filterList(category_Button_Image_title[index]);
      } 
      break; 

   } 
  
  }
  


  @override
  void onInit() async{
    super.onInit();
    await hiveController.getListVault();
  }



  

}