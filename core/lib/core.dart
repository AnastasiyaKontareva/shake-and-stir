/// The core package barrel file.
///
/// This file exports the public-facing APIs of the core package,
/// allowing other parts of the application to import them with a single line.
library core;

export 'src/l10n/gen/app_localizations.dart';
export 'src/l10n/locale_extension.dart';
export 'src/di/core_di.dart';
export 'src/services/connectivity_service.dart';
export 'src/theme/app_theme.dart';
export 'src/theme/app_colors.dart';