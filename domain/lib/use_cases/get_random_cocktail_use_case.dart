import '../models/cocktail_details.dart';
import '../repositories/cocktail_repository.dart';

class GetRandomCocktailUseCase {
  final CocktailRepository _repository;
  GetRandomCocktailUseCase(this._repository);

  Future<CocktailDetails> execute() => _repository.getRandomCocktail();
}