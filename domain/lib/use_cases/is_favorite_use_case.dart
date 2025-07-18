import '../repositories/cocktail_repository.dart';

class IsFavoriteUseCase {
  final CocktailRepository _repository;
  IsFavoriteUseCase(this._repository);
  Future<bool> execute(String cocktailId) => _repository.isFavorite(cocktailId);
}