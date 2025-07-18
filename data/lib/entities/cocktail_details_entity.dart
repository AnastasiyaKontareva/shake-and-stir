import 'package:json_annotation/json_annotation.dart';

part 'cocktail_details_entity.g.dart';

@JsonSerializable()
class CocktailDetailsListEntity {
  final List<CocktailDetailsEntity>? drinks;

  const CocktailDetailsListEntity({this.drinks});

  factory CocktailDetailsListEntity.fromJson(Map<String, dynamic> json) =>
      _$CocktailDetailsListEntityFromJson(json);
}

@JsonSerializable()
class CocktailDetailsEntity {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;
  final String? strGlass;
  final String? strInstructions;

  final String? strCategory;
  final String? strAlcoholic;

  final int? lastAccessedTimestamp;

  final String? strIngredient1,
      strIngredient2,
      strIngredient3,
      strIngredient4,
      strIngredient5,
      strIngredient6,
      strIngredient7,
      strIngredient8,
      strIngredient9,
      strIngredient10,
      strIngredient11,
      strIngredient12,
      strIngredient13,
      strIngredient14,
      strIngredient15;
  final String? strMeasure1,
      strMeasure2,
      strMeasure3,
      strMeasure4,
      strMeasure5,
      strMeasure6,
      strMeasure7,
      strMeasure8,
      strMeasure9,
      strMeasure10,
      strMeasure11,
      strMeasure12,
      strMeasure13,
      strMeasure14,
      strMeasure15;

  const CocktailDetailsEntity({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
    this.strGlass,
    this.strInstructions,
    this.lastAccessedTimestamp,

    this.strCategory,
    this.strAlcoholic,

    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
  });

  factory CocktailDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$CocktailDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CocktailDetailsEntityToJson(this);
}