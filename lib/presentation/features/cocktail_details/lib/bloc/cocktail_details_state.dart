part of 'cocktail_details_bloc.dart';

class CocktailDetailsState {
  final bool isLoading;
  final CocktailDetails? cocktail;
  final String? errorMessage;
  final bool isFavorite;

  const CocktailDetailsState({
    this.isLoading = false,
    this.cocktail,
    this.errorMessage,
    this.isFavorite = false,
  });

  factory CocktailDetailsState.initial() => const CocktailDetailsState();

  bool get hasError => errorMessage != null;

  CocktailDetailsState copyWith({
    bool? isLoading,
    CocktailDetails? cocktail,
    String? errorMessage,
    bool? isFavorite,
    bool clearError = false,
  }) {
    return CocktailDetailsState(
      isLoading: isLoading ?? this.isLoading,
      cocktail: cocktail ?? this.cocktail,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
