import 'package:cached_network_image/cached_network_image.dart';
import 'package:everbrain/presentation/Screens/accountOpt/viewAccount/view_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Model/vault_model.dart';

class PasswordItem extends StatelessWidget {
  final Vault vaultInfo;
  const PasswordItem({Key? key, required this.vaultInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: (){
            Get.to(ViewVaultScreen(vault: vaultInfo));
          },
          borderRadius: BorderRadius.circular(10),
          child: ListTile(
            tileColor: Colors.white,
            shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            leading: CircleAvatar(
              radius: Get.width*0.1,
              backgroundImage: CachedNetworkImageProvider(vaultInfo.sourceImageUrl),
            ),
            title: Text(vaultInfo.sourceName,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.AppColor.accentColor
              )
            ),
            subtitle: Text(vaultInfo.vaultName,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: colors.AppColor.subtitleColor
              ),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: vaultInfo.isFavourite ? SizedBox(
              width: Get.height*0.05,
              child: Icon(Icons.favorite_rounded, size: 20, color: colors.AppColor.fail),
            ) : const SizedBox(),
          )
        )
      )
    );
  }
}