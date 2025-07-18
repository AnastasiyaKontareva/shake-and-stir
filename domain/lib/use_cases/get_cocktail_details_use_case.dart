import '../models/cocktail_details.dart';
import '../repositories/cocktail_repository.dart';

class GetCocktailDetailsUseCase {
  final CocktailRepository _repository;
  GetCocktailDetailsUseCase({required CocktailRepository repository}) : _repository = repository;

  Future<CocktailDetails> execute(GetCocktailDetailsInput input) async {
    return _repository.getCocktailById(input.cocktailId);
  }
}

class GetCocktailDetailsInput {
  final String cocktailId;
  const GetCocktailDetailsInput({required this.cocktailId});
}