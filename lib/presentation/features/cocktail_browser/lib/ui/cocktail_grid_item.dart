import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core_ui/widgets/loading_indicator.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/navigation.dart';

class CocktailGridItem extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailGridItem({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: Theme.of(context).cardTheme.shape,
      elevation: 2,
      child: InkWell(
        onTap: () {
          context.push(
            AppRoutes.cocktailDetails.replaceFirst(':id', cocktail.id),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: cocktail.thumbnailUrl,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => const LoadingIndicator(isSmall: true),
                errorWidget:
                    (context, url, error) => const Icon(
                      Icons.local_bar,
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                cocktail.name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
