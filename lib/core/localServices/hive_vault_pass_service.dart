
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../Model/vault_model.dart';
import '../../Model/vault_password_model.dart';
import 'secure_storage_repository.dart';

class HiveVaultPassService{
  static const _VAULTPASSBOXNAME = 'vault_sivaji_pass';
 
  
  Future<Box> openBox() async{
    final encryKeyHive =
        await GetIt.I.get<LocalStorageSecure>().secureInitHiveVaultPass();
    Box<VaultPassword> box = await Hive.openBox<VaultPassword>(_VAULTPASSBOXNAME, encryptionCipher: HiveAesCipher(encryKeyHive));

    return box;
  }

  Future<void> closeBox(Box box) async{
    box.close();
  }

  Future<void> addVaultPassword({required VaultPassword vaultPass})async {
    Box vaultBox = await openBox();

    await vaultBox.put(vaultPass.valuePasswordKYS, vaultPass);

    closeBox(vaultBox);//
  }

  Future<VaultPassword?> getVaultPass({required String id})async {
    Box vaultBox = await openBox();

    final result =  vaultBox.get(id);

    closeBox(vaultBox);

    return result;
  }

  Future<void> updateVaultPass({required String valuePasswordKYS, required String vaultPass})async {
    Box vaultBox = await openBox();
    VaultPassword value = VaultPassword(valuePasswordKYS: valuePasswordKYS, vaultPassword: vaultPass);
    await vaultBox.put(valuePasswordKYS, value);

    closeBox(vaultBox);
  }

  Future<void> deleteVaultPass({required String vaultPasswordKYS})async {
    Box vaultBox = await openBox();

    await vaultBox.delete(vaultPasswordKYS);

    closeBox(vaultBox);
  }
}