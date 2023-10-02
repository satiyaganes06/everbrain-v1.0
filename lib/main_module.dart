import 'package:everbrain/core/localServices/device_info.dart';
import 'package:everbrain/core/networkService/hms_respository.dart';
import 'package:get_it/get_it.dart';

import 'core/localServices/secure_storage_repository.dart';
import 'core/localServices/secure_storage_repository_impl.dart';
import 'core/networkService/brand_api_service.dart';
import 'core/networkService/hms_respository_impl.dart';

class MainModule {
  static void init() {
    GetIt.I.registerSingletonAsync<LocalStorageSecure>(
      () async => LocalStorageSecureImpl()..init(),
    );

    GetIt.I
        .registerSingletonAsync<DeviceInfo>(() async => DeviceInfo()..init());

    GetIt.I.registerSingletonAsync<BrandApiService>(() async => BrandApiService());

    GetIt.I.registerSingletonAsync<HmsRepository>(
      () async => HmsRepositoryImpl()..initUrlCheck(),
    );
  }
}
