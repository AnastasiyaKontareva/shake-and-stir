import 'package:equatable/equatable.dart';

class ActiveFilters extends Equatable {
  final String? category;
  final String? glass;
  final String? alcoholicType;
  final Set<String> ingredients;

  const ActiveFilters({
    this.category,
    this.glass,
    this.alcoholicType,
    this.ingredients = const {},
  });

  factory ActiveFilters.initial() {
    return const ActiveFilters();
  }

  bool get isEmpty =>
      category == null &&
          glass == null &&
          alcoholicType == null &&
          ingredients.isEmpty;

  ActiveFilters copyWith({
    String? category,
    String? glass,
    String? alcoholicType,
    Set<String>? ingredients,
    bool clearCategory = false,
    bool clearGlass = false,
    bool clearAlcoholicType = false,
  }) {
    return ActiveFilters(
      category: clearCategory ? null : category ?? this.category,
      glass: clearGlass ? null : glass ?? this.glass,
      alcoholicType:
      clearAlcoholicType ? null : alcoholicType ?? this.alcoholicType,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  @override
  List<Object?> get props => [category, glass, alcoholicType, ingredients];
}