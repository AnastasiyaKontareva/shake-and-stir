import 'ingredient.dart';

class CocktailDetails {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String glass;
  final String instructions;
  final List<Ingredient> ingredients;
  final String? category;
  final String? alcoholic;

  const CocktailDetails({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.glass,
    required this.instructions,
    required this.ingredients,
    this.category,
    this.alcoholic,
  });
}