
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/constants.dart' as constants;
import '../../../../controller/signup_controller.getx.dart';

class TermAndAgreementScreen extends StatefulWidget {
  const TermAndAgreementScreen({super.key});

  @override
  State<TermAndAgreementScreen> createState() => _TermAndAgreementScreenState();
}

class _TermAndAgreementScreenState extends State<TermAndAgreementScreen> {

  final signUpController = Get.find<SignUpController>();

  final webController = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.disabled)
  ..loadRequest(Uri.parse(constants.Constants.agreementLink));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Agreement', style: GoogleFonts.poppins(
                color: colors.AppColor.secondaryColor,
                fontWeight: FontWeight.w500,
              )),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: colors.AppColor.primaryColor,
      ),
      body: WebViewWidget(controller: webController),
    );
  }
}