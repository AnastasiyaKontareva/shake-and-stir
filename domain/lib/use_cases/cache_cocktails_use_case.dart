import '../models/cocktail.dart';
import '../repositories/cocktail_repository.dart';

class CacheCocktailsUseCase {
  final CocktailRepository _repository;

  CacheCocktailsUseCase(this._repository);

  void execute(List<Cocktail> cocktails) {
    for (final cocktail in cocktails) {
      _repository.getCocktailById(cocktail.id).catchError((_) {});
    }
  }
}
