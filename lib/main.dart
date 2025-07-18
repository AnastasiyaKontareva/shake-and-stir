import 'package:cocktail_demo_app/presentation/features/cocktail_browser/lib/bloc/cocktail_browser_bloc.dart';
import 'package:cocktail_demo_app/presentation/features/favorites/lib/bloc/favorites_bloc.dart';
import 'package:settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/service_locator.dart';
import 'navigation/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => appLocator<CocktailBrowserBloc>()..add(FetchInitialListRequested()),
        ),
        BlocProvider(
          create: (context) => appLocator<FavoritesBloc>()..add(const LoadFavorites()),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(
            getSettings: appLocator(),
            saveSettings: appLocator(),
          )..add(LoadSettings()),
        ),
      ],
      child: const ShakeAndStirApp(),
    ),
  );
}

class ShakeAndStirApp extends StatelessWidget {
  const ShakeAndStirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state is SettingsLoaded ? Locale(state.settings.language) : null,
          onGenerateTitle: (context) => context.locale.appTitle,
          routerConfig: appRouter,
          theme: AppTheme.lightTheme,
          darkTheme: ThemeData.dark(),
          themeMode: state is SettingsLoaded && state.settings.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}