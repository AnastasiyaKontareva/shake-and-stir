part of 'cocktail_browser_bloc.dart';

class CocktailBrowserState {
  final bool isInitialLoading;
  final bool isPaginating;
  final List<Cocktail> cocktails;
  final String? errorMessage;
  final String nextLetterToFetch;
  final bool hasReachedMax;

  const CocktailBrowserState({
    required this.isInitialLoading,
    required this.isPaginating,
    this.cocktails = const <Cocktail>[],
    this.errorMessage,
    this.nextLetterToFetch = 'a',
    this.hasReachedMax = false,
  });

  factory CocktailBrowserState.initial() {
    return const CocktailBrowserState(
      isInitialLoading: false,
      isPaginating: false,
    );
  }

  bool get hasError => errorMessage != null;

  CocktailBrowserState copyWith({
    bool? isInitialLoading,
    bool? isPaginating,
    List<Cocktail>? cocktails,
    String? errorMessage,
    String? nextLetterToFetch,
    bool? hasReachedMax,
    bool clearError = false,
  }) {
    return CocktailBrowserState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isPaginating: isPaginating ?? this.isPaginating,
      cocktails: cocktails ?? this.cocktails,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      nextLetterToFetch: nextLetterToFetch ?? this.nextLetterToFetch,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}