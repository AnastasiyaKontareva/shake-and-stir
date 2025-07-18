import '../models/cocktail_details.dart';
import '../repositories/cocktail_repository.dart';

class ToggleFavoriteUseCase {
  final CocktailRepository _repository;
  ToggleFavoriteUseCase(this._repository);
  Future<void> execute(CocktailDetails cocktail) async {
    if (await _repository.isFavorite(cocktail.id)) {
      await _repository.deleteFavorite(cocktail.id);
    } else {
      await _repository.saveFavorite(cocktail);
    }
  }
}