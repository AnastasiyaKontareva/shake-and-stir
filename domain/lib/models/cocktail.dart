class Cocktail {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String? category;
  final String? alcoholic;

  const Cocktail({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    this.category,
    this.alcoholic,
  });
}