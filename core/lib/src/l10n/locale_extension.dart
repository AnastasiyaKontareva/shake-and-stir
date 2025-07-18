import 'package:flutter/widgets.dart';
import 'gen/app_localizations.dart';

/// Provides convenient access to the app's localizations.
extension LocaleExtension on BuildContext {
  /// Returns the localized strings for the current context.
  AppLocalizations get locale => AppLocalizations.of(this)!;
}