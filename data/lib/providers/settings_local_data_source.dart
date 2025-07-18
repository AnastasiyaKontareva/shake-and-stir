import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<Settings> getSettings();
  Future<void> saveSettings(Settings settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const _isDarkModeKey = 'is_dark_mode';
  static const _languageKey = 'language';

  final SharedPreferences _sharedPreferences;

  SettingsLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<Settings> getSettings() async {
    final isDarkMode = _sharedPreferences.getBool(_isDarkModeKey) ?? false;
    final language = _sharedPreferences.getString(_languageKey) ?? 'en';
    return Settings(isDarkMode: isDarkMode, language: language);
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await _sharedPreferences.setBool(_isDarkModeKey, settings.isDarkMode);
    await _sharedPreferences.setString(_languageKey, settings.language);
  }
}
