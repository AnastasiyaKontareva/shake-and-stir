import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/navigation.dart';
import 'package:core/core.dart';

import '../bloc/cocktail_browser_bloc.dart';
import '../bloc/favorite_status_bloc.dart';
import '../bloc/favorite_status_event.dart';
import 'cocktail_browser_body.dart';

class CocktailBrowserScreen extends StatelessWidget {
  final GetCocktailsByLetterUseCase getCocktailsByLetterUseCase;
  final WatchFavoritesUseCase watchFavoritesUseCase;
  final ToggleFavoriteStatusUseCase toggleFavoriteStatusUseCase;
  final GetCachedCocktailsUseCase getCachedCocktailsUseCase;
  final ConnectivityService connectivityService;
  final CacheCocktailsUseCase cacheCocktailsUseCase;

  const CocktailBrowserScreen({
    super.key,
    required this.getCocktailsByLetterUseCase,
    required this.watchFavoritesUseCase,
    required this.toggleFavoriteStatusUseCase,
    required this.getCachedCocktailsUseCase,
    required this.connectivityService,
    required this.cacheCocktailsUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CocktailBrowserBloc>(
          create: (context) => CocktailBrowserBloc(
            getCocktailsByLetterUseCase: getCocktailsByLetterUseCase,
            getCachedCocktailsUseCase: getCachedCocktailsUseCase,
            connectivityService: connectivityService,
            cacheCocktailUseCase: cacheCocktailsUseCase,
          )..add(FetchInitialListRequested()),
        ),
        BlocProvider<FavoriteStatusBloc>(
          create: (context) => FavoriteStatusBloc(
            watchFavoritesUseCase: watchFavoritesUseCase,
            toggleFavoriteStatusUseCase: toggleFavoriteStatusUseCase,
          )..add(WatchFavoriteStatus()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.cocktailBrowserScreenTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.push(AppRoutes.settings),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => context.push(AppRoutes.search),
            ),
          ],
        ),
        body: const CocktailBrowserBody(),
      ),
    );
  }
}