// ignore_for_file: sort_child_properties_last

import 'package:everbrain/presentation/Screens/dashboard/dashboard_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everbrain/utils/colors.dart' as colors;

import '../../controller/login_controller.getx.dart';

class WideButton extends StatelessWidget {
  String title;
  Function operation;

  final loginController = Get.find<LoginController>();
  
  WideButton(this.title, this.operation);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 36, 56, 70),
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.grey[200],
      elevation: 6.1,
      child: InkWell(
        onTap: operation as void Function()? ?? (){},
        child: Container(
          width: double.infinity,
          height: 60,
          child: Center(
            child: Text('$title',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color:Colors.white
              ),
            )
          ),
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(20),
      )
    );
  }
}