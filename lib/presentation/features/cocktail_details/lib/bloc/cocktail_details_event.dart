part of 'cocktail_details_bloc.dart';

abstract class CocktailDetailsEvent {}

class FetchDetailsRequested extends CocktailDetailsEvent {
  final String cocktailId;

  FetchDetailsRequested({required this.cocktailId});
}

class FavoriteToggled extends CocktailDetailsEvent {}