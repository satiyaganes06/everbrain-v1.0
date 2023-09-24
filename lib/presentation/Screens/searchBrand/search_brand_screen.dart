
import 'package:everbrain/Model/brand_model.dart';
import 'package:everbrain/presentation/Widget/brand_item.dart';
import 'package:everbrain/presentation/Widget/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/search_brand_controller.getx.dart';
import '../../Widget/appbar.dart';

class SearchBrandScreen extends StatelessWidget {
  bool? isFromEdit;
  SearchBrandScreen({super.key, this.isFromEdit});

  @override
  Widget build(BuildContext context) {

    final searchBrandCtrl = Get.put(SearchBrandController());
    print(isFromEdit);
    return Scaffold(
      appBar: CommonAppbar(
        title: constants.Constants.addAccountTitle,
      ),
      body: Scaffold(
        backgroundColor: colors.AppColor.secondaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  //  controller: searchCtrl,
                  onChanged: (value) async {
                    await searchBrandCtrl.getInput(value);
                  },
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      prefixIcon: const Icon(Icons.search, size: 25),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      filled: true,
                      fillColor: colors.AppColor.lightGrey,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5)
                      
                  ),
                ),
              ),

              BrandItem(
                isFromEdit: isFromEdit ?? false,
                mainItem: true,
                brandInfo: Brand(
                claimed: false,
                name: "",
                domain: "",
                icons: "",
                brandId: "1",
              )),

              Obx(() => searchBrandCtrl.isLoading.value == false ? Column(
                children: searchBrandCtrl.brands.value.isNotEmpty ? List.generate(searchBrandCtrl.brands.value.length, (index) => BrandItem(isFromEdit: isFromEdit ?? false, mainItem: false, brandInfo: searchBrandCtrl.brands.value[index])
                ) :[
                  const SizedBox(height: 20,),
                  Image.asset('assets/images/empty_list.png',width: Get.width*0.3),
                  Text(searchBrandCtrl.errorMessage, style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.AppColor.accentColor)),]
              ) : loading()
              )
              
              

            ],
          ),
        ),
      ),
    );
  }

  loading(){
    return Column(
      children: List.generate(3, (index) => shimmerEffectBrandSearch())
    );
  }
}

// List.generate(searchBrandCtrl.brands.value.length, (index) => Brand(
//                   claimed: searchBrandCtrl.brands.value[index].claimed, 
//                   name: searchBrandCtrl.brands.value[index].name, 
//                   domain: searchBrandCtrl.brands.value[index].domain, 
//                   icons: searchBrandCtrl.brands.value[index].icons, 
//                   brandId: searchBrandCtrl.brands.value[index].brandId
//                   )
//                 )