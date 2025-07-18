import 'dart:async';
import 'package:domain/domain.dart';
import 'package:domain/use_cases/toggle_favorite_status_use_case.dart';
import 'package:domain/use_cases/watch_favorites_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final WatchFavoritesUseCase _watchFavoritesUseCase;
  StreamSubscription? _favoritesSubscription;
  final ToggleFavoriteStatusUseCase _toggleFavoriteStatusUseCase;

  FavoritesBloc({
    required WatchFavoritesUseCase watchFavoritesUseCase,
    required ToggleFavoriteStatusUseCase toggleFavoriteStatusUseCase,
  }) : _watchFavoritesUseCase = watchFavoritesUseCase,
       _toggleFavoriteStatusUseCase = toggleFavoriteStatusUseCase,
       super(const FavoritesState()) {
    on<FavoritesSubscriptionRequested>(_onFavoritesSubscriptionRequested);
    on<_FavoritesUpdated>(_onFavoritesUpdated);
    on<ToggleFavoriteRequested>(_onToggleFavoriteRequested);
  }

  Future<void> _onToggleFavoriteRequested(
    ToggleFavoriteRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    await _toggleFavoriteStatusUseCase.execute(event.cocktail);
  }

  void _onFavoritesSubscriptionRequested(
    FavoritesSubscriptionRequested event,
    Emitter<FavoritesState> emit,
  ) {
    _favoritesSubscription?.cancel();
    _favoritesSubscription = _watchFavoritesUseCase.execute().listen(
      (cocktails) => add(_FavoritesUpdated(cocktails)),
    );
  }

  void _onFavoritesUpdated(
    _FavoritesUpdated event,
    Emitter<FavoritesState> emit,
  ) {
    emit(state.copyWith(cocktails: event.cocktails));
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
