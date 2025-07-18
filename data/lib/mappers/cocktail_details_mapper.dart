import 'package:domain/domain.dart';
import '../entities/cocktail_details_entity.dart';

class CocktailDetailsMapper {
  static CocktailDetails toDomain(CocktailDetailsEntity entity) {
    final ingredients = <Ingredient>[];
    final ingredientsMap = {
      1: entity.strIngredient1, 2: entity.strIngredient2, 3: entity.strIngredient3, 4: entity.strIngredient4, 5: entity.strIngredient5,
      6: entity.strIngredient6, 7: entity.strIngredient7, 8: entity.strIngredient8, 9: entity.strIngredient9, 10: entity.strIngredient10,
      11: entity.strIngredient11, 12: entity.strIngredient12, 13: entity.strIngredient13, 14: entity.strIngredient14, 15: entity.strIngredient15,
    };
    final measuresMap = {
      1: entity.strMeasure1, 2: entity.strMeasure2, 3: entity.strMeasure3, 4: entity.strMeasure4, 5: entity.strMeasure5,
      6: entity.strMeasure6, 7: entity.strMeasure7, 8: entity.strMeasure8, 9: entity.strMeasure9, 10: entity.strMeasure10,
      11: entity.strMeasure11, 12: entity.strMeasure12, 13: entity.strMeasure13, 14: entity.strMeasure14, 15: entity.strMeasure15,
    };

    for (int i = 1; i <= 15; i++) {
      final ingredientName = ingredientsMap[i];
      if (ingredientName != null && ingredientName.trim().isNotEmpty) {
        ingredients.add(Ingredient(
          name: ingredientName,
          measure: measuresMap[i] ?? '',
        ));
      }
    }

    return CocktailDetails(
      id: entity.idDrink,
      name: entity.strDrink,
      thumbnailUrl: entity.strDrinkThumb,
      glass: entity.strGlass ?? 'N/A',
      instructions: entity.strInstructions ?? 'No instructions available.',
      ingredients: ingredients,
      category: entity.strCategory,
      alcoholic: entity.strAlcoholic,
    );
  }

  static CocktailDetailsEntity toEntity(CocktailDetails model) {
    final ingredients = List<String?>.filled(15, null);
    final measures = List<String?>.filled(15, null);

    for (int i = 0; i < model.ingredients.length && i < 15; i++) {
      ingredients[i] = model.ingredients[i].name;
      measures[i] = model.ingredients[i].measure;
    }

    return CocktailDetailsEntity(
      idDrink: model.id,
      strDrink: model.name,
      strDrinkThumb: model.thumbnailUrl,
      strGlass: model.glass,
      strInstructions: model.instructions,
      strCategory: model.category,
      strAlcoholic: model.alcoholic,
      strIngredient1: ingredients[0],
      strIngredient2: ingredients[1],
      strIngredient3: ingredients[2],
      strIngredient4: ingredients[3],
      strIngredient5: ingredients[4],
      strIngredient6: ingredients[5],
      strIngredient7: ingredients[6],
      strIngredient8: ingredients[7],
      strIngredient9: ingredients[8],
      strIngredient10: ingredients[9],
      strIngredient11: ingredients[10],
      strIngredient12: ingredients[11],
      strIngredient13: ingredients[12],
      strIngredient14: ingredients[13],
      strIngredient15: ingredients[14],
      strMeasure1: measures[0],
      strMeasure2: measures[1],
      strMeasure3: measures[2],
      strMeasure4: measures[3],
      strMeasure5: measures[4],
      strMeasure6: measures[5],
      strMeasure7: measures[6],
      strMeasure8: measures[7],
      strMeasure9: measures[8],
      strMeasure10: measures[9],
      strMeasure11: measures[10],
      strMeasure12: measures[11],
      strMeasure13: measures[12],
      strMeasure14: measures[13],
      strMeasure15: measures[14],
    );
  }
}