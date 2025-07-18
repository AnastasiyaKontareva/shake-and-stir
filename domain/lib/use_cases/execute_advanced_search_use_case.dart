import '../models/active_filters.dart';
import '../models/cocktail.dart';
import '../repositories/cocktail_repository.dart';

class ExecuteAdvancedSearchUseCase {
  final CocktailRepository _repository;

  ExecuteAdvancedSearchUseCase(this._repository);

  Future<List<Cocktail>> execute(String query, ActiveFilters filters) {
    return _repository.executeAdvancedSearch(query, filters);
  }
}
