import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/cocktail_details_entity.dart';

class CacheProvider {
  late final SharedPreferences _prefs;
  static const _cacheKeyPrefix = 'cache_';
  static const _lruListKey = 'cache_lru_list';
  static const int _maxCacheSize = 50;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveCocktail(CocktailDetailsEntity cocktail) async {
    final lruList = _prefs.getStringList(_lruListKey) ?? [];

    lruList.remove(cocktail.idDrink);
    lruList.add(cocktail.idDrink);

    if (lruList.length > _maxCacheSize) {
      final keyToRemove = lruList.removeAt(0);
      await _prefs.remove('$_cacheKeyPrefix$keyToRemove');
    }

    final updatedCocktail = CocktailDetailsEntity(
      idDrink: cocktail.idDrink,
      strDrink: cocktail.strDrink,
      strDrinkThumb: cocktail.strDrinkThumb,
      strGlass: cocktail.strGlass,
      strInstructions: cocktail.strInstructions,
      strCategory: cocktail.strCategory,
      strAlcoholic: cocktail.strAlcoholic,
      lastAccessedTimestamp: DateTime.now().millisecondsSinceEpoch,
      strIngredient1: cocktail.strIngredient1,
      strIngredient2: cocktail.strIngredient2,
      strIngredient3: cocktail.strIngredient3,
      strIngredient4: cocktail.strIngredient4,
      strIngredient5: cocktail.strIngredient5,
      strIngredient6: cocktail.strIngredient6,
      strIngredient7: cocktail.strIngredient7,
      strIngredient8: cocktail.strIngredient8,
      strIngredient9: cocktail.strIngredient9,
      strIngredient10: cocktail.strIngredient10,
      strIngredient11: cocktail.strIngredient11,
      strIngredient12: cocktail.strIngredient12,
      strIngredient13: cocktail.strIngredient13,
      strIngredient14: cocktail.strIngredient14,
      strIngredient15: cocktail.strIngredient15,
      strMeasure1: cocktail.strMeasure1,
      strMeasure2: cocktail.strMeasure2,
      strMeasure3: cocktail.strMeasure3,
      strMeasure4: cocktail.strMeasure4,
      strMeasure5: cocktail.strMeasure5,
      strMeasure6: cocktail.strMeasure6,
      strMeasure7: cocktail.strMeasure7,
      strMeasure8: cocktail.strMeasure8,
      strMeasure9: cocktail.strMeasure9,
      strMeasure10: cocktail.strMeasure10,
      strMeasure11: cocktail.strMeasure11,
      strMeasure12: cocktail.strMeasure12,
      strMeasure13: cocktail.strMeasure13,
      strMeasure14: cocktail.strMeasure14,
      strMeasure15: cocktail.strMeasure15,
    );

    await _prefs.setString(
      '$_cacheKeyPrefix${cocktail.idDrink}',
      jsonEncode(updatedCocktail.toJson()),
    );
    await _prefs.setStringList(_lruListKey, lruList);
  }

  CocktailDetailsEntity? getCocktail(String cocktailId) {
    final jsonString = _prefs.getString('$_cacheKeyPrefix$cocktailId');
    if (jsonString == null) return null;

    final lruList = _prefs.getStringList(_lruListKey) ?? [];
    lruList.remove(cocktailId);
    lruList.add(cocktailId);
    _prefs.setStringList(_lruListKey, lruList);

    return CocktailDetailsEntity.fromJson(jsonDecode(jsonString));
  }

  List<CocktailDetailsEntity> getAllCachedCocktails() {
    final lruList = _prefs.getStringList(_lruListKey) ?? [];
    final cocktails = <CocktailDetailsEntity>[];
    // Iterate in reverse for most-recently-used first
    for (final key in lruList.reversed) {
      final jsonString = _prefs.getString('$_cacheKeyPrefix$key');
      if (jsonString != null) {
        cocktails.add(CocktailDetailsEntity.fromJson(jsonDecode(jsonString)));
      }
    }
    return cocktails;
  }
}
