import 'package:cached_network_image/cached_network_image.dart';
import 'package:everbrain/presentation/Screens/accountOpt/addAccount/add_new_account.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:octo_image/octo_image.dart';

import '../../Model/brand_model.dart';
import '../../controller/search_brand_controller.getx.dart';

class BrandItem extends StatelessWidget {
  final Brand brandInfo;
  bool mainItem;
  bool isFromEdit;
  BrandItem({Key? key, required this.brandInfo, required this.mainItem, required this.isFromEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     final customCacheManager = CacheManager(
      Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: (){
               // Get.to(() => ViewVaultScreen(vault: brandInfo));
               isFromEdit ? Get.find<SearchBrandController>().returnEditResult(brandInfo) :
               Get.to(()=> mainItem ? AddNewAccount() : AddNewAccount(brandDomain: brandInfo.domain, brandIcon: brandInfo.icons, brandName: brandInfo.name));
              },
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                tileColor: colors.AppColor.secondaryColor,
                leading:  CircleAvatar(
                  backgroundColor: colors.AppColor.secondaryColor,
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      cacheManager: customCacheManager,
                          imageUrl: mainItem ? 'https://firebasestorage.googleapis.com/v0/b/everbrain-a6262.appspot.com/o/Company%20Logo%2Fadd_photo.png?alt=media&token=dd4fea24-8c82-4f17-9cc4-fac6f2159160' : 
                        isUrl(brandInfo.icons) ? brandInfo.icons : constants.Constants.emptyIconPath,
                      placeholder: (context, url) =>  Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: CircularProgressIndicator( color: colors.AppColor.accentColor,)
                        )
                      ),
                      errorWidget: (context, url, error) =>  Container(
                        color: colors.AppColor.fail,
                        child: Icon(Icons.error, color: colors.AppColor.secondaryColor,)
                      ),
                    )
                  )
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(mainItem ? 'Add new vault' : brandInfo.domain,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.AppColor.accentColor
                  )
                ),
                
                trailing:  Icon(Icons.arrow_forward_ios_rounded, color: colors.AppColor.accentColor, size: 15,),
            )
          )
          ),

          Divider(
            color: colors.AppColor.lightGrey.withOpacity(0.5),
            thickness: 1,
          )
        ]
      ));
  }

  bool isUrl(String input) {
    RegExp urlPattern = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
      caseSensitive: false,
      multiLine: false,
    );

    return urlPattern.hasMatch(input);
  }

  String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
    ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';


}

// trailing: brandInfo.isFavourite ? SizedBox(
//               width: Get.height*0.05,
//               child: Icon(Icons.favorite_rounded, size: 20, color: colors.AppColor.fail),
//             ) : const SizedBox(),