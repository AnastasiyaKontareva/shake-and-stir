import '../models/active_filters.dart';
import '../models/cocktail.dart';
import '../models/cocktail_details.dart';

/// Abstract repository for managing cocktail data.
abstract class CocktailRepository {
  /// Fetches a list of cocktails from the data source by their first letter.
  Future<List<Cocktail>> getCocktailsByFirstLetter(String letter);

  Future<CocktailDetails> getCocktailById(String id);

  Future<List<Cocktail>> searchCocktailsByName(String name);

  Future<void> saveFavorite(CocktailDetails cocktail);

  Future<void> deleteFavorite(String cocktailId);

  Future<bool> isFavorite(String cocktailId);

  Stream<List<Cocktail>> watchFavorites();

  Future<List<Cocktail>> getAllCachedCocktails();

  Future<CocktailDetails> getRandomCocktail();

  Future<List<String>> getCategories();

  Future<List<String>> getGlasses();

  Future<List<String>> getIngredients();

  Future<List<Cocktail>> filterByIngredient(String ingredient);

  Future<List<Cocktail>> filterByCategory(String category);

  Future<List<Cocktail>> executeAdvancedSearch(
    String query,
    ActiveFilters filters,
  );
}
