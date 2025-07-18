part of 'search_cocktails_bloc.dart';

abstract class SearchCocktailsEvent {}

class SearchQueryChanged extends SearchCocktailsEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class SearchSubmitted extends SearchCocktailsEvent {}

class FilterIconTapped extends SearchCocktailsEvent {}

class FiltersApplied extends SearchCocktailsEvent {
  final ActiveFilters filters;

  FiltersApplied(this.filters);
}

class FilterRemoved extends SearchCocktailsEvent {
  final dynamic filter;

  FilterRemoved(this.filter);
}

class FiltersReset extends SearchCocktailsEvent {}
