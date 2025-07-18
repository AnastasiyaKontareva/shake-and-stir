import 'package:equatable/equatable.dart';

class FilterOptions extends Equatable {
  final List<String> categories;
  final List<String> glasses;
  final List<String> ingredients;
  final List<String> alcoholicTypes;

  const FilterOptions({
    this.categories = const [],
    this.glasses = const [],
    this.ingredients = const [],
    this.alcoholicTypes = const [],
  });

  @override
  List<Object?> get props => [categories, glasses, ingredients, alcoholicTypes];
}