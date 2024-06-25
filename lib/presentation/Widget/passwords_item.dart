import 'package:cached_network_image/cached_network_image.dart';
import 'package:everbrain/controller/edit_account_controller.getx.dart';
import 'package:everbrain/controller/hive_controller.getx.dart';
import 'package:everbrain/presentation/Screens/accountOpt/viewAccount/view_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';

import '../../Model/vault_model.dart';

class PasswordItem extends StatelessWidget {
  final Vault vaultInfo;
  PasswordItem({Key? key, required this.vaultInfo}) : super(key: key);

  final customCacheManager = CacheManager(
      Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ));

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>EditAccountController());
    final  hiveController = Get.find<HiveController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: (){
            
            Get.to(() => ViewVaultScreen(vault: vaultInfo));
          },
          
            splashColor: Colors.transparent,
            focusColor:  Colors.transparent,
            hoverColor: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: ListTile(
            tileColor: colors.AppColor.secondaryColor,
            splashColor: Colors.transparent,
            focusColor:  Colors.transparent,
            hoverColor: Colors.transparent,
            leading: Hero(
              tag: vaultInfo.vaultID,
              child: OctoImage.fromSet(
                    width: Get.height*0.06,
                    image: CachedNetworkImageProvider(vaultInfo.websiteImageUrl, cacheManager: customCacheManager),
                    octoSet: OctoSet.circleAvatar(
                      backgroundColor: colors.AppColor.secondaryColor, text: Center(child: CircularProgressIndicator(color: colors.AppColor.accentColor,),),
                    ),
                    fit: BoxFit.cover,
                  ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(vaultInfo.vaultName,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.AppColor.accentColor
              )
            ),
            subtitle: Text(vaultInfo.username,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: colors.AppColor.subtitleColor
              ),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: colors.AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Container(
                  decoration: BoxDecoration(
                    color: colors.AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(50)
                  ),
                    child: Center(
                        child: IconButton(
                          onPressed: () async{
                            var pss = await hiveController.getVaultPassword(vaultInfo.vaultID);
                            Get.lazyPut(()=>EditAccountController());
                            Get.find<EditAccountController>().funPasswordCopy(context, password: pss);
                          },
                          color: colors.AppColor.tertiaryColor,
                          iconSize: 15,
                          splashRadius: 25,
                          splashColor: colors.AppColor.tertiaryColor,
                          icon: const Icon(Icons.copy_rounded),
                        ),)
                  ),
                ),
                

                
              ]
            ),
          )
        )
      )
    );
  }

  bool isUrl(String input) {
    RegExp urlPattern = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
      caseSensitive: false,
      multiLine: false,
    );

    return urlPattern.hasMatch(input);
  }
}

// trailing: vaultInfo.isFavourite ? SizedBox(
//               width: Get.height*0.05,
//               child: Icon(Icons.favorite_rounded, size: 20, color: colors.AppColor.fail),
//             ) : const SizedBox(),