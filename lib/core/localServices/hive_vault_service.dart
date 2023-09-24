
import 'package:everbrain/controller/login_controller.getx.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../Model/vault_model.dart';
import 'secure_storage_repository.dart';

class HiveVaultService{
  static const _VAULTBOXNAME = 'vault_sivaji';
  
  Future<Box> openBox() async{
    final encryKeyHive =
        await GetIt.I.get<LocalStorageSecure>().secureInitHiveVault();
    Box<Vault> box = await Hive.openBox<Vault>(_VAULTBOXNAME, encryptionCipher: HiveAesCipher(encryKeyHive));

    return box;
  }

  Future<void> closeBox(Box box) async{
    box.close();
  }

  Future<void> addVault({required Vault vault})async {
    Box vaultBox = await openBox();

    await vaultBox.put(vault.vaultID, vault);

    closeBox(vaultBox);//
  }

  Future<List<Vault>> getVaultList() async{
    final loginCotrl  = Get.find<LoginController>();
    Box vaultBox = await openBox();
    var result = vaultBox.values.toList()as List<Vault>;
    closeBox(vaultBox);
    return result.where((vault) => vault.userID == loginCotrl.firebaseService.currentUser!.uid).toList() ;
  }

  Future<Vault?> getVault({required String id})async {
    Box vaultBox = await openBox();

    final result =  vaultBox.get(id);

    closeBox(vaultBox);

    return result;
  }

  Future<void> updateVault({required Vault vault})async {
    Box vaultBox = await openBox();

    await vaultBox.put(vault.vaultID, vault);

   closeBox(vaultBox);
  }

  Future<void> deleteVault({required Vault vault})async {
    Box vaultBox = await openBox();

    await vaultBox.delete(vault.vaultID);

    closeBox(vaultBox);
  }
}