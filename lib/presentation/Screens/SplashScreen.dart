import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final hEgth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: double.infinity,
        color: colors.AppColor.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/splash_screen_Animation.json',
                height: hEgth*0.1
              ),
              Text(
                'Everbrain',
                style: GoogleFonts.poppins(
                    color: colors.AppColor.secondaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 21
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
