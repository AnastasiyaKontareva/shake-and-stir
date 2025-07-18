import 'package:cocktail_browser/bloc/favorite_status_bloc.dart';
import 'package:cocktail_browser/bloc/favorite_status_event.dart';
import 'package:cocktail_browser/bloc/favorite_status_state.dart';
import 'package:cocktail_browser/ui/cocktail_tile_item.dart';
import 'package:core_ui/widgets/error_view.dart';
import 'package:core_ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_cocktails_bloc.dart';

class SearchCocktailsBody extends StatelessWidget {
  const SearchCocktailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen to the favorite status
    return BlocBuilder<FavoriteStatusBloc, FavoriteStatusState>(
      builder: (context, favoriteState) {
        // 2. Listen to the search status
        return BlocBuilder<SearchCocktailsBloc, SearchCocktailsState>(
          builder: (context, searchState) {
            if (searchState.isLoading) return const LoadingIndicator();

            if (searchState.hasError) {
              return ErrorView(message: searchState.errorMessage, onRetry: () {
                context.read<SearchCocktailsBloc>().add(SearchQueryChanged(searchState.query));
              });
            }

            if (searchState.searchResults == null) {
              return const Center(child: Text('Start typing to find a cocktail.'));
            }

            if (searchState.searchResults!.isEmpty) {
              return Center(child: Text('No results found for "${searchState.query}".'));
            }

            return ListView.builder(
              itemCount: searchState.searchResults!.length,
              itemBuilder: (context, index) {
                final cocktail = searchState.searchResults![index];
                final isFavorite = favoriteState.favoriteIds.contains(cocktail.id);

                return CocktailTileItem(
                  cocktail: cocktail,
                  isFavorite: isFavorite,
                  onFavoriteTapped: () {
                    context
                        .read<FavoriteStatusBloc>()
                        .add(ToggleFavoriteStatus(cocktail: cocktail));
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}