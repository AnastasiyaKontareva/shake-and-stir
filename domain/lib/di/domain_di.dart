import 'package:get_it/get_it.dart';

import '../repositories/cocktail_repository.dart';
import '../use_cases/cache_cocktails_use_case.dart';
import '../use_cases/execute_advanced_search_use_case.dart';
import '../use_cases/get_cached_cocktails_use_case.dart';
import '../use_cases/get_cocktail_details_use_case.dart';
import '../use_cases/get_cocktails_by_letter_use_case.dart';
import '../use_cases/get_filter_options_use_case.dart';
import '../use_cases/get_random_cocktail_use_case.dart';
import '../use_cases/is_favorite_use_case.dart';
import '../use_cases/search_cocktails_by_name_use_case.dart';
import '../use_cases/toggle_favorite_status_use_case.dart';
import '../use_cases/toggle_favorite_use_case.dart';
import '../use_cases/watch_favorites_use_case.dart';

/// The dependency injection setup for the domain layer.
final DomainDI domainDI = DomainDI();

class DomainDI {
  /// Registers all domain layer dependencies.
  void initDomainDependencies(GetIt serviceLocator) {
    serviceLocator.registerFactory<GetCocktailsByLetterUseCase>(
      () => GetCocktailsByLetterUseCase(
        repository: serviceLocator<CocktailRepository>(),
      ),
    );

    serviceLocator.registerFactory<GetCocktailDetailsUseCase>(
      () => GetCocktailDetailsUseCase(
        repository: serviceLocator<CocktailRepository>(),
      ),
    );

    serviceLocator.registerFactory<SearchCocktailsByNameUseCase>(
      () => SearchCocktailsByNameUseCase(
        repository: serviceLocator<CocktailRepository>(),
      ),
    );

    serviceLocator.registerFactory<IsFavoriteUseCase>(
      () => IsFavoriteUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<WatchFavoritesUseCase>(
      () => WatchFavoritesUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<ToggleFavoriteStatusUseCase>(
      () => ToggleFavoriteStatusUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<GetCachedCocktailsUseCase>(
      () => GetCachedCocktailsUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<CacheCocktailsUseCase>(
      () => CacheCocktailsUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<GetRandomCocktailUseCase>(
      () => GetRandomCocktailUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<ExecuteAdvancedSearchUseCase>(
      () => ExecuteAdvancedSearchUseCase(serviceLocator<CocktailRepository>()),
    );
    serviceLocator.registerFactory<GetFilterOptionsUseCase>(
      () => GetFilterOptionsUseCase(serviceLocator<CocktailRepository>()),
    );
  }
}
