import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'ingredients_list_view.dart';
import 'instructions_view.dart';

class DetailsContentView extends StatelessWidget {
  final CocktailDetails cocktail;

  const DetailsContentView({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            imageUrl: cocktail.thumbnailUrl,
            fit: BoxFit.cover,
            height: 350,
            placeholder: (context, url) =>
            const Center(heightFactor: 2, child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
            const SizedBox(height: 350, child: Icon(Icons.error, size: 50)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cocktail.name, style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 32),

                _buildSectionTitle(context, AppLocalizations.of(context)!.cocktailDetailsGlassTitle),
                Text(
                  cocktail.glass,
                  style: textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 32),

                _buildSectionTitle(context, AppLocalizations.of(context)!.cocktailDetailsIngredientsTitle),
                IngredientsListView(ingredients: cocktail.ingredients),
                const SizedBox(height: 32),

                _buildSectionTitle(context, AppLocalizations.of(context)!.cocktailDetailsInstructionsTitle),
                InstructionsView(instructions: cocktail.instructions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}