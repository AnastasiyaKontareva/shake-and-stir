import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cocktail_details_event.dart';

part 'cocktail_details_state.dart';

class CocktailDetailsBloc
    extends Bloc<CocktailDetailsEvent, CocktailDetailsState> {
  final GetCocktailDetailsUseCase _getDetailsUseCase;
  final IsFavoriteUseCase _isFavoriteUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  CocktailDetailsBloc({
    required GetCocktailDetailsUseCase getDetailsUseCase,
    required IsFavoriteUseCase isFavoriteUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
  }) : _getDetailsUseCase = getDetailsUseCase,
       _isFavoriteUseCase = isFavoriteUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       super(CocktailDetailsState.initial()) {
    on<FetchDetailsRequested>(_onFetchDetailsRequested);
    on<FavoriteToggled>(_onFavoriteToggled);
  }

  Future<void> _onFetchDetailsRequested(
    FetchDetailsRequested event,
    Emitter<CocktailDetailsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final input = GetCocktailDetailsInput(cocktailId: event.cocktailId);
      final cocktailDetails = await _getDetailsUseCase.execute(input);

      final isFavorite = await _isFavoriteUseCase.execute(cocktailDetails.id);

      emit(
        state.copyWith(
          isLoading: false,
          cocktail: cocktailDetails,
          isFavorite: isFavorite,
        ),
      );
    } on DomainException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load cocktail details.',
        ),
      );
    }
  }

  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<CocktailDetailsState> emit,
  ) async {
    if (state.cocktail == null) return;

    await _toggleFavoriteUseCase.execute(state.cocktail!);

    emit(state.copyWith(isFavorite: !state.isFavorite));
  }
}
