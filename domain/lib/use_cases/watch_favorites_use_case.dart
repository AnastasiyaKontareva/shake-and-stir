import '../models/cocktail.dart';
import '../repositories/cocktail_repository.dart';

class WatchFavoritesUseCase {
  final CocktailRepository _repository;

  WatchFavoritesUseCase(this._repository);

  Stream<List<Cocktail>> execute() => _repository.watchFavorites();
}
