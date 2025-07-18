import 'package:core_ui/widgets/error_view.dart';
import 'package:core_ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';

import '../bloc/cocktail_browser_bloc.dart';
import '../bloc/favorite_status_bloc.dart';
import '../bloc/favorite_status_event.dart';
import '../bloc/favorite_status_state.dart';
import 'cocktail_list_view.dart';

class CocktailBrowserBody extends StatelessWidget {
  const CocktailBrowserBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteStatusBloc, FavoriteStatusState>(
      builder: (context, favoriteState) {
        return BlocBuilder<CocktailBrowserBloc, CocktailBrowserState>(
          builder: (context, browserState) {
            if (browserState.isInitialLoading) {
              return const LoadingIndicator();
            }

            if (browserState.hasError && browserState.cocktails.isEmpty) {
              return ErrorView(
                message: browserState.errorMessage,
                onRetry: () {
                  context.read<CocktailBrowserBloc>().add(
                    FetchInitialListRequested(),
                  );
                },
              );
            }

            if (browserState.cocktails.isEmpty &&
                !browserState.isInitialLoading) {
              return Center(child: Text(AppLocalizations.of(context)!.cocktailBrowserBodyNoCocktailsFound));
            }

            return CocktailListView(
              cocktails: browserState.cocktails,
              hasReachedMax: browserState.hasReachedMax,
              isPaginating: browserState.isPaginating,
              favoriteIds: favoriteState.favoriteIds,
              onFavoriteTapped: (cocktail) {
                context.read<FavoriteStatusBloc>().add(
                  ToggleFavoriteStatus(cocktail: cocktail),
                );
              },
            );
          },
        );
      },
    );
  }
}
