import 'package:data/providers/settings_local_data_source.dart';
import 'package:domain/domain.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Settings> getSettings() => localDataSource.getSettings();

  @override
  Future<void> saveSettings(Settings settings) =>
      localDataSource.saveSettings(settings);
}
