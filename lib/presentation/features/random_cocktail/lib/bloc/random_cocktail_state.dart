part of 'random_cocktail_bloc.dart';

class RandomCocktailState {
  final bool isLoading;
  final CocktailDetails? cocktail;
  final String? errorMessage;

  const RandomCocktailState({
    required this.isLoading,
    this.cocktail,
    this.errorMessage,
  });

  factory RandomCocktailState.initial() {
    return const RandomCocktailState(
      isLoading: false,
      cocktail: null,
      errorMessage: null,
    );
  }

  RandomCocktailState copyWith({
    bool? isLoading,
    CocktailDetails? cocktail,
    String? errorMessage,
    bool clearCocktail = false,
    bool clearError = false,
  }) {
    return RandomCocktailState(
      isLoading: isLoading ?? this.isLoading,
      cocktail: clearCocktail ? null : cocktail ?? this.cocktail,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}