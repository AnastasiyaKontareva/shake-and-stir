import '../models/filter_options.dart';
import '../repositories/cocktail_repository.dart';

class GetFilterOptionsUseCase {
  final CocktailRepository _repository;

  GetFilterOptionsUseCase(this._repository);

  Future<FilterOptions> execute() async {
    final results = await Future.wait([
      _repository.getCategories(),
      _repository.getGlasses(),
      _repository.getIngredients(),
    ]);
    return FilterOptions(
      categories: results[0],
      glasses: results[1],
      ingredients: results[2],
    );
  }
}
