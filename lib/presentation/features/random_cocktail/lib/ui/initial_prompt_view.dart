import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import '../bloc/random_cocktail_bloc.dart';

class InitialPromptView extends StatelessWidget {
  const InitialPromptView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS;
    final localizations = AppLocalizations.of(context)!;
    final String promptText = isMobile
        ? localizations.randomCocktailShakePrompt
        : localizations.randomCocktailClickPrompt;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              promptText,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
              icon: const Icon(Icons.local_drink_outlined),
              label: Text(localizations.randomCocktailSurpriseMeButton),
              onPressed: () {
                context.read<RandomCocktailBloc>().add(
                  RandomCocktailRequested(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}