import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Settings settings;

  const SettingsLoaded(this.settings);

  @override
  List<Object> get props => [settings];

  SettingsLoaded copyWith({
    Settings? settings,
  }) {
    return SettingsLoaded(
      settings ?? this.settings,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object> get props => [message];
}
