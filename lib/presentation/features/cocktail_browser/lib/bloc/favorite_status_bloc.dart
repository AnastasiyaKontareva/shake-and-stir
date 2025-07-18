import 'dart:async';

import 'package:domain/models/cocktail.dart';
import 'package:domain/use_cases/toggle_favorite_status_use_case.dart';
import 'package:domain/use_cases/watch_favorites_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_status_event.dart';
import 'favorite_status_state.dart';

class FavoriteStatusBloc
    extends Bloc<FavoriteStatusEvent, FavoriteStatusState> {
  final WatchFavoritesUseCase _watchFavoritesUseCase;
  final ToggleFavoriteStatusUseCase _toggleFavoriteStatusUseCase;
  StreamSubscription? _favoritesSubscription;

  FavoriteStatusBloc({
    required WatchFavoritesUseCase watchFavoritesUseCase,
    required ToggleFavoriteStatusUseCase toggleFavoriteStatusUseCase,
  }) : _watchFavoritesUseCase = watchFavoritesUseCase,
       _toggleFavoriteStatusUseCase = toggleFavoriteStatusUseCase,
       super(const FavoriteStatusState()) {
    on<WatchFavoriteStatus>(_onWatchStatus);
    on<ToggleFavoriteStatus>(_onToggleFavorite);
  }

  Future<void> _onWatchStatus(
    WatchFavoriteStatus event,
    Emitter<FavoriteStatusState> emit,
  ) async {
    await emit.onEach<List<Cocktail>>(
      _watchFavoritesUseCase.execute(),
      onData: (favorites) {
        final ids = favorites.map((c) => c.id).toSet();
        emit(FavoriteStatusState(favoriteIds: ids));
      },
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteStatus event,
    Emitter<FavoriteStatusState> emit,
  ) async {
    await _toggleFavoriteStatusUseCase.execute(event.cocktail);
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
