import 'dart:convert';
import 'dart:typed_data';
import 'package:everbrain/utils/constants.dart' as constants;
import 'package:everbrain/utils/keys.dart' as KY;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'secure_storage_repository.dart';

class LocalStorageSecureImpl extends LocalStorageSecure {
  FlutterSecureStorage? storage;
  
  @override
  Future<void> init() async {
    AndroidOptions getAndroidOptions() => AndroidOptions(
        keyCipherAlgorithm:
            KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
        storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
        encryptedSharedPreferences: true,
        sharedPreferencesName: constants.Constants.hiveStorageName);

    IOSOptions getIOSOptions() => IOSOptions(
        accountName: constants.Constants.hiveStorageName,
        accessibility: KeychainAccessibility.unlocked_this_device);

    storage = FlutterSecureStorage(
        aOptions: getAndroidOptions(), iOptions: getIOSOptions());
  }

  @override
  Future<LocalStorageResult> saveString(String key, String value) async {
    if (storage == null) await init();
    try {
      await storage?.write(key: key, value: value);
      return LocalStorageResult.saved;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }


  @override
  Future<String?> getString(String key) async {
    if (storage == null) await init();

    try {
      return await storage?.read(key: key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<LocalStorageResult> removeData(String key) async {
    if (storage == null) await init();

    try {
      await storage?.delete(key: key);
      return LocalStorageResult.deleted;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }
  
  @override
  Future<Uint8List> secureInitHiveVault() async{

    if (storage == null) await init();

    try {
      final encryptionKey = await storage?.read(key: KY.KYS.hiveKY);

      if (encryptionKey == null) {
        final key = Hive.generateSecureKey();
        await storage?.write(
          key: KY.KYS.hiveKY,
          value: base64UrlEncode(key),
        );
      }

      final encryptionKey2 = await storage?.read(key: KY.KYS.hiveKY);
      final encryptionKeyConfirm = base64Url.decode(encryptionKey2!);
      
      //await storage?.write(key: key, value: );
      return encryptionKeyConfirm;
    } catch (e) {

      return Uint8List(1);
    }
  }

  @override
  Future<Uint8List> secureInitHiveVaultPass() async{

    if (storage == null) await init();

    try {
      final encryptionKey = await storage?.read(key: KY.KYS.hivePassKY);

      if (encryptionKey == null) {
        final key = Hive.generateSecureKey();
        await storage?.write(
          key: KY.KYS.hivePassKY,
          value: base64UrlEncode(key),
        );
      }

      final encryptionKey2 = await storage?.read(key: KY.KYS.hivePassKY);
      final encryptionKeyConfirm = base64Url.decode(encryptionKey2!);
      
      //await storage?.write(key: key, value: );
      return encryptionKeyConfirm;
    } catch (e) {

      return Uint8List(1);
    }
  }
}


