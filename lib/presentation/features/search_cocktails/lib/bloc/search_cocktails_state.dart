part of 'search_cocktails_bloc.dart';

class SearchCocktailsState {
  final String query;
  final bool isLoading;
  final List<Cocktail>? searchResults;
  final ActiveFilters activeFilters;
  final String? errorMessage;
  final FilterOptions? filterOptions;

  const SearchCocktailsState({
    this.activeFilters = const ActiveFilters(),
    this.query = '',
    this.isLoading = false,
    this.searchResults,
    this.errorMessage,
    this.filterOptions,
  });

  factory SearchCocktailsState.initial() => const SearchCocktailsState();

  bool get hasError => errorMessage != null;

  SearchCocktailsState copyWith({
    String? query,
    bool? isLoading,
    List<Cocktail>? searchResults,
    String? errorMessage,
    bool clearResults = false,
    ActiveFilters? activeFilters,
    FilterOptions? filterOptions,
  }) {
    return SearchCocktailsState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      searchResults: clearResults ? null : searchResults ?? this.searchResults,
      errorMessage: errorMessage,
      activeFilters: activeFilters ?? this.activeFilters,
      filterOptions: filterOptions ?? this.filterOptions,
    );
  }
}
