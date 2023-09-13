import 'package:everbrain/presentation/Widget/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:everbrain/utils/colors.dart' as colors;

class CategoryButton extends StatelessWidget {

  String category_Button_Image_path;
  String category_Button_Title;

  CategoryButton(this.category_Button_Image_path, this.category_Button_Title);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height:Get.height*0.08,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.AppColor.shadowColor,
                offset: const Offset(1, 2),
                blurRadius: 5,
                spreadRadius: 0.6,
              ), //BoxShadow
            ],
          ),
          
          child: OctoImage(
              image: AssetImage(category_Button_Image_path.toString()),
              errorBuilder: OctoError.icon(color: colors.AppColor.accentColor),
              fit: BoxFit.cover,
              imageBuilder: OctoImageTransformer.circleAvatar(),
          )
        ),
          Text(category_Button_Title.toString(),
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colors.AppColor.accentColor
          ),
          overflow: TextOverflow.fade,  
        ),
        
      ],
    );
  }

}