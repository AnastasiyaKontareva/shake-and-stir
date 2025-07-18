import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

class SaveSettings extends SettingsEvent {
  final Settings settings;

  const SaveSettings(this.settings);

  @override
  List<Object> get props => [settings];
}
