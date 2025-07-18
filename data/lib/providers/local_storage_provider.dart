import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/cocktail_details_entity.dart';

class LocalStorageProvider {
  late final SharedPreferences _prefs;
  final _controller = StreamController<List<CocktailDetailsEntity>>.broadcast();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveFavorite(CocktailDetailsEntity cocktail) async {
    final jsonString = jsonEncode(cocktail.toJson());
    await _prefs.setString(cocktail.idDrink, jsonString);
    _notifyListeners();
  }

  Future<void> deleteFavorite(String cocktailId) async {
    await _prefs.remove(cocktailId);
    _notifyListeners();
  }

  bool isFavorite(String cocktailId) {
    return _prefs.containsKey(cocktailId);
  }

  List<CocktailDetailsEntity> getAllFavorites() {
    final keys = _prefs.getKeys();
    final favorites = <CocktailDetailsEntity>[];
    for (final key in keys) {
      if (int.tryParse(key) != null) {
        final jsonString = _prefs.getString(key);
        if (jsonString != null) {
          favorites.add(CocktailDetailsEntity.fromJson(jsonDecode(jsonString)));
        }
      }
    }
    return favorites;
  }

  Stream<List<CocktailDetailsEntity>> watchFavorites() async* {
    yield getAllFavorites();
    yield* _controller.stream;
  }

  void _notifyListeners() {
    _controller.add(getAllFavorites());
  }

  void dispose() {
    _controller.close();
  }
}