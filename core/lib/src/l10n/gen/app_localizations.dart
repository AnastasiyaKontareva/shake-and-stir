import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Shake & Stir'**
  String get appTitle;

  /// Tooltip for the filter button on the search cocktails screen
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get searchCocktailsScreenFilterButtonTooltip;

  /// Title for the filter panel
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filterPanelTitle;

  /// Title for the category section in the filter panel
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get filterPanelCategoryTitle;

  /// Title for the glass type section in the filter panel
  ///
  /// In en, this message translates to:
  /// **'Glass Type'**
  String get filterPanelGlassTypeTitle;

  /// Title for the alcoholic type section in the filter panel
  ///
  /// In en, this message translates to:
  /// **'Alcoholic Type'**
  String get filterPanelAlcoholicTypeTitle;

  /// Label for the reset all button in the filter panel
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get filterPanelResetAllButton;

  /// Label for the apply filters button in the filter panel
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get filterPanelApplyFiltersButton;

  /// Title for the contains ingredients section in the filter panel
  ///
  /// In en, this message translates to:
  /// **'Contains Ingredients'**
  String get filterPanelContainsIngredientsTitle;

  /// Label for the add an ingredient text field in the filter panel
  ///
  /// In en, this message translates to:
  /// **'Add an ingredient'**
  String get filterPanelAddAnIngredientLabel;

  /// Initial prompt in the search cocktails body
  ///
  /// In en, this message translates to:
  /// **'Start typing to find a cocktail.'**
  String get searchCocktailsBodyInitialPrompt;

  /// Message displayed when no search results are found
  ///
  /// In en, this message translates to:
  /// **'No results found for \"{query}\".'**
  String searchCocktailsBodyNoResults(String query);

  /// Title for the cocktail browser screen
  ///
  /// In en, this message translates to:
  /// **'Browse Cocktails'**
  String get cocktailBrowserScreenTitle;

  /// Message displayed when no cocktails are found in the cocktail browser
  ///
  /// In en, this message translates to:
  /// **'No Cocktails Found'**
  String get cocktailBrowserBodyNoCocktailsFound;

  /// Title for the cocktail details screen
  ///
  /// In en, this message translates to:
  /// **'Recipe Details'**
  String get cocktailDetailsScreenTitle;

  /// No description provided for @cocktailDetailsGlassTitle.
  ///
  /// In en, this message translates to:
  /// **'Glass Type'**
  String get cocktailDetailsGlassTitle;

  /// Label for the glass type in the cocktail details view
  ///
  /// In en, this message translates to:
  /// **'Serve in: {glass}'**
  String cocktailDetailsServeIn(String glass);

  /// Title for the ingredients section in the cocktail details view
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get cocktailDetailsIngredientsTitle;

  /// Title for the instructions section in the cocktail details view
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get cocktailDetailsInstructionsTitle;

  /// Message displayed when there are no favorite cocktails
  ///
  /// In en, this message translates to:
  /// **'No Favorites Yet. Tap the ♡ on any cocktail.'**
  String get favoritesBodyNoFavorites;

  /// Prompt to shake the phone for a random cocktail
  ///
  /// In en, this message translates to:
  /// **'Shake your phone to get a random cocktail!'**
  String get randomCocktailShakePrompt;

  /// Prompt to click the button for a random cocktail
  ///
  /// In en, this message translates to:
  /// **'Click the button to get a random cocktail!'**
  String get randomCocktailClickPrompt;

  /// Label for the surprise me button in the random cocktail view
  ///
  /// In en, this message translates to:
  /// **'Surprise Me!'**
  String get randomCocktailSurpriseMeButton;

  /// Title for the result view in the random cocktail feature
  ///
  /// In en, this message translates to:
  /// **'We found one for you!'**
  String get randomCocktailResultTitle;

  /// Label for the view full recipe button in the random cocktail result view
  ///
  /// In en, this message translates to:
  /// **'View Full Recipe'**
  String get randomCocktailViewRecipeButton;

  /// Label for the find another button in the random cocktail result view
  ///
  /// In en, this message translates to:
  /// **'Find Another'**
  String get randomCocktailFindAnotherButton;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
