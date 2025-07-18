import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_cocktails_event.dart';

part 'search_cocktails_state.dart';

const _duration = Duration(milliseconds: 500);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchCocktailsBloc
    extends Bloc<SearchCocktailsEvent, SearchCocktailsState> {
  final ExecuteAdvancedSearchUseCase _executeAdvancedSearchUseCase;
  final GetFilterOptionsUseCase _getFilterOptionsUseCase;

  SearchCocktailsBloc({
    required ExecuteAdvancedSearchUseCase executeAdvancedSearchUseCase,
    required GetFilterOptionsUseCase getFilterOptionsUseCase,
  }) : _executeAdvancedSearchUseCase = executeAdvancedSearchUseCase,
       _getFilterOptionsUseCase = getFilterOptionsUseCase,
       super(const SearchCocktailsState()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounce(_duration),
    );
    on<SearchSubmitted>(_onSearchSubmitted);
    on<FilterIconTapped>(_onFilterIconTapped);
    on<FiltersApplied>(_onFiltersApplied);
    on<FilterRemoved>(_onFilterRemoved);
    on<FiltersReset>(_onFiltersReset);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchCocktailsState> emit,
  ) async {
    emit(state.copyWith(query: event.query));
    await _executeSearch(event.query, state.activeFilters, emit);
  }

  Future<void> _onSearchSubmitted(
    SearchSubmitted event,
    Emitter<SearchCocktailsState> emit,
  ) async {
    await _executeSearch(state.query, state.activeFilters, emit);
  }

  Future<void> _onFilterIconTapped(
    FilterIconTapped event,
    Emitter<SearchCocktailsState> emit,
  ) async {
    if (state.filterOptions == null) {
      final options = await _getFilterOptionsUseCase.execute();
      emit(state.copyWith(filterOptions: options));
    }
  }

  Future<void> _onFiltersApplied(
    FiltersApplied event,
    Emitter<SearchCocktailsState> emit,
  ) async {
    emit(state.copyWith(activeFilters: event.filters));
    await _executeSearch(state.query, event.filters, emit);
  }

  Future<void> _onFiltersReset(
    FiltersReset event,
    Emitter<SearchCocktailsState> emit,
  ) async {
    final clearedFilters = ActiveFilters.initial();
    emit(state.copyWith(activeFilters: clearedFilters));
    await _executeSearch(state.query, clearedFilters, emit);
  }

  Future<void> _onFilterRemoved(
    FilterRemoved event,
    Emitter<SearchCocktailsState> emit,
  ) async {
    final currentFilters = state.activeFilters;
    ActiveFilters newFilters;

    if (event.filter == currentFilters.category) {
      newFilters = currentFilters.copyWith(clearCategory: true);
    } else if (event.filter == currentFilters.glass) {
      newFilters = currentFilters.copyWith(clearGlass: true);
    } else if (currentFilters.ingredients.contains(event.filter)) {
      final newIngredients = Set<String>.from(currentFilters.ingredients)
        ..remove(event.filter);
      newFilters = currentFilters.copyWith(ingredients: newIngredients);
    } else {
      return;
    }

    emit(state.copyWith(activeFilters: newFilters));
    await _executeSearch(state.query, newFilters, emit);
  }

  Future<void> _executeSearch(
    String query,
    ActiveFilters filters,
    Emitter<SearchCocktailsState> emit,
  ) async {
    if (query.trim().isEmpty && filters.isEmpty) {
      emit(state.copyWith(isLoading: false, searchResults: []));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final results = await _executeAdvancedSearchUseCase.execute(
        query,
        filters,
      );
      emit(state.copyWith(isLoading: false, searchResults: results));
    } on DomainException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Search failed. Please try again.',
        ),
      );
    }
  }
}
