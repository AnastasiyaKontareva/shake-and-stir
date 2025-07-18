import 'package:domain/models/cocktail.dart';

abstract class FavoriteStatusEvent {}

/// Event to start listening to the favorites stream.
class WatchFavoriteStatus extends FavoriteStatusEvent {}

/// Event to toggle the favorite status of a specific cocktail.
class ToggleFavoriteStatus extends FavoriteStatusEvent {
  final Cocktail cocktail;
  ToggleFavoriteStatus({required this.cocktail});
}