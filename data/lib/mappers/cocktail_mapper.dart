import 'package:domain/domain.dart';
import '../entities/cocktail_details_entity.dart';
import '../entities/cocktail_entity.dart';

/// Maps data between the Data and Domain layers for cocktails.
class CocktailMapper {
  static Cocktail toDomain(CocktailEntity entity) {
    return Cocktail(
      id: entity.idDrink,
      name: entity.strDrink,
      thumbnailUrl: '${entity.strDrinkThumb}/small',
      category: entity.strCategory,
      alcoholic: entity.strAlcoholic,
    );
  }

  static Cocktail fromDetailsEntity(CocktailDetailsEntity entity) {
    return Cocktail(
      id: entity.idDrink,
      name: entity.strDrink,
      thumbnailUrl: '${entity.strDrinkThumb}/small',
      category: entity.strCategory,
      alcoholic: entity.strAlcoholic,
    );
  }
}