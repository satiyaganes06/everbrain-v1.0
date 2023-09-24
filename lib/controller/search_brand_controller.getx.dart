

import 'package:everbrain/controller/edit_account_controller.getx.dart';
import 'package:everbrain/core/networkService/brand_api_service.dart';
import 'package:get/get.dart';

import '../Model/brand_model.dart';


class SearchBrandController extends GetxController{
 // var searchValue = "";
 RxList<Brand> brands = <Brand>[].obs;
 RxBool isLoading = false.obs;
 BrandApiService brandSearchService = BrandApiService();
 String errorMessage = "";

  @override
 onInit(){
   super.onInit();
   isLoading.value = false;
   brands.value = [
      Brand(
        claimed: false,
        name: "Facebook",
        domain: "facebook.com",
        icons: "https://logo.clearbit.com/facebook.com",
        brandId: "2"
      ),
      Brand(
        claimed: false,
        name: "Instagram",
        domain: "instagram.com",
        icons: "https://logo.clearbit.com/instagram.com",
        brandId: "4"
      ),
      Brand(
        claimed: false,
        name: "Youtube",
        domain: "youtube.com",
        icons: "https://logo.clearbit.com/youtube.com",
        brandId: "5"
      ),
      Brand(
        claimed: false,
        name: "Linkedin",
        domain: "linkedin.com",
        icons: "https://logo.clearbit.com/linkedin.com",
        brandId: "6"
      ),
      Brand(
        claimed: false,
        name: "Tiktok",
        domain: "tiktok.com",
        icons: "https://logo.clearbit.com/tiktok.com",
        brandId: "9"
      ),
      Brand(
        claimed: false,
        name: "Whatsapp",
        domain: "whatsapp.com",
        icons: "https://logo.clearbit.com/whatsapp.com",
        brandId: "10"
      ),
      Brand(
        claimed: false,
        name: "Snapchat",
        domain: "snapchat.com",
        icons: "https://logo.clearbit.com/snapchat.com",
        brandId: "11"
      ),
   ];
 
 
 }

 returnEditResult(Brand brand){
  print(brand.name);
    Get.find<EditAccountController>().vaultNameCtrl.text = brand.name;
    Get.find<EditAccountController>().vaultWebsiteURLCtrl = brand.icons;
    Get.back();
 }

 

  Future<void> getInput(String value) async{
    if(value.isNotEmpty){
      isLoading.value = true;
      brands.value = await brandSearchService.fetchBrandData(value);
      isLoading.value = false;

    }else{
      brands.value = [];
    }
  }
}