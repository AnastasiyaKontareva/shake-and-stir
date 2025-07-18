import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/providers/cache_provider.dart';
import 'package:data/providers/local_storage_provider.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navigation/app_router.dart';

final GetIt appLocator = GetIt.instance;

Future<void> setupDependencies() async {
  appLocator.registerLazySingleton<GoRouter>(() => appRouter);

  coreDI.initCoreDependencies(appLocator);
  dataDI.initDataDependencies(appLocator);
  domainDI.initDomainDependencies(appLocator);

  // Settings DI
  appLocator.registerLazySingleton(() => GetSettingsUseCase(appLocator()));
  appLocator.registerLazySingleton(() => SaveSettingsUseCase(appLocator()));
  appLocator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: appLocator()),
  );

  // External
  if (!appLocator.isRegistered<SharedPreferences>()) {
    final sharedPreferences = await SharedPreferences.getInstance();
    appLocator.registerLazySingleton(() => sharedPreferences);
  }

  await appLocator<LocalStorageProvider>().init();
  await appLocator<CacheProvider>().init();
}
