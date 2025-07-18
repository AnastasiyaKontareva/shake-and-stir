import '../models/cocktail.dart';
import '../repositories/cocktail_repository.dart';

/// Use case for fetching the initial list of cocktails (those starting with 'a').
class GetCocktailsByLetterUseCase {
  final CocktailRepository _repository;

  GetCocktailsByLetterUseCase({required CocktailRepository repository})
      : _repository = repository;

  Future<List<Cocktail>> execute(GetCocktailsByLetterInput input) async {
    return _repository.getCocktailsByFirstLetter(input.letter);
  }
}

/// Defines the input for the GetCocktailsByLetterUseCase.
class GetCocktailsByLetterInput {
  final String letter;
  const GetCocktailsByLetterInput({required this.letter});
}