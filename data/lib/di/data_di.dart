import 'package:data/providers/cache_provider.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/local_storage_provider.dart';
import '../providers/network_provider.dart';
import '../repositories/cocktail_repository_impl.dart';
import '../providers/settings_local_data_source.dart';

final DataDI dataDI = DataDI();

class DataDI {
  void initDataDependencies(GetIt serviceLocator) {
    serviceLocator.registerLazySingleton<NetworkProvider>(() => NetworkProvider());
    serviceLocator.registerLazySingleton<LocalStorageProvider>(
        () => LocalStorageProvider());
    serviceLocator.registerLazySingleton<CacheProvider>(() => CacheProvider());

    serviceLocator.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(serviceLocator<SharedPreferences>()),
    );

    serviceLocator.registerLazySingleton<CocktailRepository>(
      () => CocktailRepositoryImpl(
        networkProvider: serviceLocator<NetworkProvider>(),
        localStorageProvider: serviceLocator<LocalStorageProvider>(),
        cacheProvider: serviceLocator<CacheProvider>(),
        connectivityService: serviceLocator<ConnectivityService>(),
      ),
    );
  }
}