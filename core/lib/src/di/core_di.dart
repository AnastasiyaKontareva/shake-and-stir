import '../services/connectivity_service.dart';
import 'package:get_it/get_it.dart';

final CoreDI coreDI = CoreDI();

class CoreDI {
  void initCoreDependencies(GetIt serviceLocator) {
    serviceLocator.registerLazySingleton<ConnectivityService>(
        () => ConnectivityService());
  }
}
