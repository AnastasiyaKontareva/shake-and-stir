import 'package:domain/domain.dart';

class GetSettingsUseCase {
  final SettingsRepository _repository;

  GetSettingsUseCase(this._repository);

  Future<Settings> execute() => _repository.getSettings();
}
