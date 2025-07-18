import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase _getSettings;
  final SaveSettingsUseCase _saveSettings;

  SettingsBloc({
    required GetSettingsUseCase getSettings,
    required SaveSettingsUseCase saveSettings,
  })  : _getSettings = getSettings,
        _saveSettings = saveSettings,
        super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<SaveSettings>(_onSaveSettings);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    final result = await _getSettings.execute();
    emit(SettingsLoaded(result));
  }

  Future<void> _onSaveSettings(SaveSettings event, Emitter<SettingsState> emit) async {
    await _saveSettings.execute(event.settings);
    emit(SettingsLoaded(event.settings));
  }
}
