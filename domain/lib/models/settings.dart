import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final bool isDarkMode;
  final String language;

  const Settings({
    required this.isDarkMode,
    required this.language,
  });

  @override
  List<Object?> get props => [isDarkMode, language];

  Settings copyWith({
    bool? isDarkMode,
    String? language,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }
}
