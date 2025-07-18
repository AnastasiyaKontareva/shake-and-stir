import 'package:domain/use_cases/toggle_favorite_status_use_case.dart';
import 'package:domain/use_cases/watch_favorites_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorites_bloc.dart';
import 'favorites_body.dart';

class FavoritesScreen extends StatelessWidget {
  final WatchFavoritesUseCase watchFavoritesUseCase;
  final ToggleFavoriteStatusUseCase toggleFavoriteStatusUseCase;

  const FavoritesScreen({
    super.key,
    required this.watchFavoritesUseCase,
    required this.toggleFavoriteStatusUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesBloc>(
      create:
          (context) => FavoritesBloc(
            watchFavoritesUseCase: watchFavoritesUseCase,
            toggleFavoriteStatusUseCase: toggleFavoriteStatusUseCase,
          )..add(FavoritesSubscriptionRequested()),
      child: const Scaffold(body: FavoritesBody()),
    );
  }
}
