import '../models/cocktail.dart';
import '../repositories/cocktail_repository.dart';

class SearchCocktailsByNameUseCase {
  final CocktailRepository _repository;

  SearchCocktailsByNameUseCase({required CocktailRepository repository})
    : _repository = repository;

  Future<List<Cocktail>> execute(SearchCocktailsByNameInput input) async {
    if (input.query.trim().isEmpty) return [];
    return _repository.searchCocktailsByName(input.query);
  }
}

class SearchCocktailsByNameInput {
  final String query;

  const SearchCocktailsByNameInput({required this.query});
}
