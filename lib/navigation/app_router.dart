import 'package:cocktail_demo_app/presentation/features/cocktail_browser/lib/ui/cocktail_browser_screen.dart';
import 'package:domain/domain.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/navigation.dart';
import 'package:settings/settings.dart';

import '../di/service_locator.dart';
import 'package:cocktail_demo_app/presentation/features/cocktail_details/lib/ui/cocktail_details_screen.dart';
import 'package:cocktail_demo_app/presentation/features/favorites/lib/ui/favorites_screen.dart';
import 'package:cocktail_demo_app/presentation/features/random_cocktail/lib/ui/random_cocktail_screen.dart';
import 'package:cocktail_demo_app/presentation/features/search_cocktails/lib/ui/search_cocktails_screen.dart';
import 'main_scaffold.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.initial,
          builder: (context, state) {
            return CocktailBrowserScreen(
              getCocktailsByLetterUseCase:
                  appLocator<GetCocktailsByLetterUseCase>(),
              watchFavoritesUseCase: appLocator<WatchFavoritesUseCase>(),
              toggleFavoriteStatusUseCase:
                  appLocator<ToggleFavoriteStatusUseCase>(),
              getCachedCocktailsUseCase:
                  appLocator<GetCachedCocktailsUseCase>(),
              connectivityService: appLocator<ConnectivityService>(),
              cacheCocktailsUseCase: appLocator<CacheCocktailsUseCase>(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.favorites,
          builder: (context, state) {
            final watchUseCase = appLocator<WatchFavoritesUseCase>();
            final toggleUseCase = appLocator<ToggleFavoriteStatusUseCase>();

            return FavoritesScreen(
              watchFavoritesUseCase: watchUseCase,
              toggleFavoriteStatusUseCase: toggleUseCase,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.cocktailDetails,
      builder: (context, state) {
        final cocktailId = state.pathParameters['id'] ?? '0';
        return CocktailDetailsScreen(
          cocktailId: cocktailId,
          getDetailsUseCase: appLocator<GetCocktailDetailsUseCase>(),
          isFavoriteUseCase: appLocator<IsFavoriteUseCase>(),
          toggleFavoriteUseCase: appLocator<ToggleFavoriteUseCase>(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) {
        return SearchCocktailsScreen(
          executeAdvancedSearchUseCase:
              appLocator<ExecuteAdvancedSearchUseCase>(),
          getFilterOptionsUseCase: appLocator<GetFilterOptionsUseCase>(),
          watchFavoritesUseCase: appLocator<WatchFavoritesUseCase>(),
          toggleFavoriteStatusUseCase: appLocator<ToggleFavoriteStatusUseCase>(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.random,
      builder: (context, state) {
        return RandomCocktailScreen(
          getRandomCocktailUseCase: appLocator<GetRandomCocktailUseCase>(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) {
        return const SettingsScreen();
      },
    ),
  ],
);
