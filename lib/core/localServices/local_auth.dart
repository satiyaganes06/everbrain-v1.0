
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static AuthenticationOptions authOptions = const AuthenticationOptions(
    stickyAuth: true,
    useErrorDialogs: true
  );

  static Future<bool> hasBiometrics() async{
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate(String title) async {
    final isAvailable = await hasBiometrics();

    if(!isAvailable) return false;
    
    try {
      return await _auth.authenticate(
        localizedReason: title,
        options : authOptions
      );
    } on PlatformException catch (e) {
      return false;
    }
  }
 
}