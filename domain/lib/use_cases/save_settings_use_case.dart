import 'package:domain/domain.dart';

class SaveSettingsUseCase {
  final SettingsRepository _repository;

  SaveSettingsUseCase(this._repository);

  Future<void> execute(Settings settings) => _repository.saveSettings(settings);
}
