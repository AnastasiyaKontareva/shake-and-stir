import '../models/cocktail.dart';
import '../models/cocktail_details.dart';
import '../repositories/cocktail_repository.dart';

class ToggleFavoriteStatusUseCase {
  final CocktailRepository _repository;
  ToggleFavoriteStatusUseCase(this._repository);

  Future<void> execute(Cocktail cocktail) async {
    final isCurrentlyFavorite = await _repository.isFavorite(cocktail.id);

    if (isCurrentlyFavorite) {
      await _repository.deleteFavorite(cocktail.id);
    } else {
      final CocktailDetails details = await _repository.getCocktailById(cocktail.id);
      await _repository.saveFavorite(details);
    }
  }
}