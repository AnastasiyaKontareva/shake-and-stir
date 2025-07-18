// packages/navigation/lib/src/app_routes.dart

/// Defines all route path constants used across the application.
///
/// This decouples features from each other, as they can navigate
/// by using these constants instead of importing other feature screens directly.
class AppRoutes {
  static const String initial = '/';
  static const String cocktailDetails = '/cocktail/:id';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String random = '/random';
  static const String settings = '/settings';
}
