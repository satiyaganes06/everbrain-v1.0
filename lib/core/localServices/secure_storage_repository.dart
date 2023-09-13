
import 'dart:typed_data';

enum LocalStorageResult {
  saved,
  deleted,
  failed,
}

abstract class LocalStorageSecure {
  Future<void> init();
  Future<LocalStorageResult> saveString(String key, String value);
  Future<Uint8List> secureInitHive();
  Future<String?> getString(String key);
  Future<LocalStorageResult> removeData(String key);
}