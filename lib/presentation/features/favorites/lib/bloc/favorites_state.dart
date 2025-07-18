part of 'favorites_bloc.dart';

class FavoritesState {
  final bool isLoading;
  final List<Cocktail> cocktails;

  const FavoritesState({
    this.isLoading = true,
    this.cocktails = const [],
  });

  FavoritesState copyWith({
    bool? isLoading,
    List<Cocktail>? cocktails,
  }) {
    return FavoritesState(
      isLoading: isLoading ?? this.isLoading,
      cocktails: cocktails ?? this.cocktails,
    );
  }
}