
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo{
  var device = DeviceInfoPlugin();
  String deviceModel = '';
  String deviceIP = '';
  String deviceOs = '';

  Future<void> init() async{

    deviceOs = Platform.operatingSystem;
   // await getIPAddress();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await device.androidInfo;
      deviceModel = androidInfo.model;

    } else if(Platform.isIOS) {

      IosDeviceInfo iosInfo = await device.iosInfo;
      deviceModel = iosInfo.utsname.machine;

    }
  }

  // Future getIPAddress() async{
  //  try {
  //     final url = Uri.parse('https://api.ipify.org/');
  //     final response = await http.get(url);

  //     deviceIP = response.body;

  //  } catch (e) {
  //     debugPrint(e.toString());
  //     deviceIP = '';
  //  }
  // }
}