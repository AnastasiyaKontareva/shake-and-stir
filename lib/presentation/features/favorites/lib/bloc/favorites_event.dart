part of 'favorites_bloc.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

class FavoritesSubscriptionRequested extends FavoritesEvent {
  const FavoritesSubscriptionRequested();
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class ToggleFavoriteRequested extends FavoritesEvent {
  final Cocktail cocktail;

  const ToggleFavoriteRequested(this.cocktail);
}

class _FavoritesUpdated extends FavoritesEvent {
  final List<Cocktail> cocktails;

  const _FavoritesUpdated(this.cocktails);
}