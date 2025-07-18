import '../models/cocktail.dart';
import '../repositories/cocktail_repository.dart';

class GetCachedCocktailsUseCase {
  final CocktailRepository _repository;
  GetCachedCocktailsUseCase(this._repository);
  Future<List<Cocktail>> execute() => _repository.getAllCachedCocktails();
}