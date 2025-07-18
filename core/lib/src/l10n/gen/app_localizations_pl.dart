// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Shake & Stir';

  @override
  String get searchCocktailsScreenFilterButtonTooltip => 'Filters';

  @override
  String get filterPanelTitle => 'Filters';

  @override
  String get filterPanelCategoryTitle => 'Category';

  @override
  String get filterPanelGlassTypeTitle => 'Glass Type';

  @override
  String get filterPanelAlcoholicTypeTitle => 'Alcoholic Type';

  @override
  String get filterPanelResetAllButton => 'Reset All';

  @override
  String get filterPanelApplyFiltersButton => 'Apply Filters';

  @override
  String get filterPanelContainsIngredientsTitle => 'Contains Ingredients';

  @override
  String get filterPanelAddAnIngredientLabel => 'Add an ingredient';

  @override
  String get searchCocktailsBodyInitialPrompt => 'Start typing to find a cocktail.';

  @override
  String searchCocktailsBodyNoResults(String query) {
    return 'No results found for \"$query\".';
  }

  @override
  String get cocktailBrowserScreenTitle => 'Browse Cocktails';

  @override
  String get cocktailBrowserBodyNoCocktailsFound => 'No Cocktails Found';

  @override
  String get cocktailDetailsScreenTitle => 'Recipe Details';

  @override
  String get cocktailDetailsGlassTitle => 'Glass Type';

  @override
  String cocktailDetailsServeIn(String glass) {
    return 'Serve in: $glass';
  }

  @override
  String get cocktailDetailsIngredientsTitle => 'Ingredients';

  @override
  String get cocktailDetailsInstructionsTitle => 'Instructions';

  @override
  String get favoritesBodyNoFavorites => 'No Favorites Yet. Tap the ♡ on any cocktail.';

  @override
  String get randomCocktailShakePrompt => 'Shake your phone to get a random cocktail!';

  @override
  String get randomCocktailClickPrompt => 'Click the button to get a random cocktail!';

  @override
  String get randomCocktailSurpriseMeButton => 'Surprise Me!';

  @override
  String get randomCocktailResultTitle => 'We found one for you!';

  @override
  String get randomCocktailViewRecipeButton => 'View Full Recipe';

  @override
  String get randomCocktailFindAnotherButton => 'Find Another';
}
