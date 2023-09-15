import 'package:everbrain/core/localServices/device_info.dart';
import 'package:get_it/get_it.dart';

import 'core/localServices/secure_storage_repository.dart';
import 'core/localServices/secure_storage_repository_impl.dart';

class MainModule {
  static void init() {
    GetIt.I.registerSingletonAsync<LocalStorageSecure>(
      () async => LocalStorageSecureImpl()..init(),
    );

    GetIt.I
        .registerSingletonAsync<DeviceInfo>(() async => DeviceInfo()..init());
  }
}
