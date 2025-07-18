// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CocktailListEntity _$CocktailListEntityFromJson(Map<String, dynamic> json) =>
    CocktailListEntity(
      drinks:
          (json['drinks'] as List<dynamic>?)
              ?.map((e) => CocktailEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CocktailListEntityToJson(CocktailListEntity instance) =>
    <String, dynamic>{'drinks': instance.drinks};

CocktailEntity _$CocktailEntityFromJson(Map<String, dynamic> json) =>
    CocktailEntity(
      idDrink: json['idDrink'] as String,
      strDrink: json['strDrink'] as String,
      strDrinkThumb: json['strDrinkThumb'] as String,
      strCategory: json['strCategory'] as String?,
      strAlcoholic: json['strAlcoholic'] as String?,
    );

Map<String, dynamic> _$CocktailEntityToJson(CocktailEntity instance) =>
    <String, dynamic>{
      'idDrink': instance.idDrink,
      'strDrink': instance.strDrink,
      'strDrinkThumb': instance.strDrinkThumb,
      'strCategory': instance.strCategory,
      'strAlcoholic': instance.strAlcoholic,
    };
