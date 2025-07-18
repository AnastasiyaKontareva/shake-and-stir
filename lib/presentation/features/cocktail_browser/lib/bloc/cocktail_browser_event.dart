part of 'cocktail_browser_bloc.dart';

abstract class CocktailBrowserEvent {}

/// Event triggered to fetch the initial list of cocktails.
class FetchInitialListRequested extends CocktailBrowserEvent {}

/// Event triggered when the user scrolls to the end of the list.
class FetchNextPageRequested extends CocktailBrowserEvent {}