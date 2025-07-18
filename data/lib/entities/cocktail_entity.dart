import 'package:json_annotation/json_annotation.dart';

part 'cocktail_entity.g.dart';

/// Represents the root object of the cocktail list API response.
@JsonSerializable()
class CocktailListEntity {
  final List<CocktailEntity>? drinks;

  const CocktailListEntity({this.drinks});

  factory CocktailListEntity.fromJson(Map<String, dynamic> json) =>
      _$CocktailListEntityFromJson(json);
}

/// Represents a single cocktail item from the API response.
@JsonSerializable()
class CocktailEntity {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;
  final String? strCategory;
  final String? strAlcoholic;

  const CocktailEntity({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
    this.strCategory,
    this.strAlcoholic,
  });

  factory CocktailEntity.fromJson(Map<String, dynamic> json) =>
      _$CocktailEntityFromJson(json);
}