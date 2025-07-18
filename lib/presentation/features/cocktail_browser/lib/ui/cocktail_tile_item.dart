import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/navigation.dart';

class CocktailTileItem extends StatelessWidget {
  final Cocktail cocktail;
  final bool isFavorite;
  final VoidCallback onFavoriteTapped;

  const CocktailTileItem({
    super.key,
    required this.cocktail,
    required this.isFavorite,
    required this.onFavoriteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          AppRoutes.cocktailDetails.replaceFirst(':id', cocktail.id),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: cocktail.thumbnailUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      width: 64,
                      height: 64,
                      color: Colors.grey.shade200,
                    ),
                errorWidget:
                    (context, url, error) => const Icon(Icons.local_bar),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cocktail.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (cocktail.category != null)
                    Text(
                      cocktail.category!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            // The favorite button.
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: AppColors.primary,
              ),
              onPressed: onFavoriteTapped,
            ),
          ],
        ),
      ),
    );
  }
}
