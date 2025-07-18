import 'package:cocktail_browser/bloc/favorite_status_bloc.dart';
import 'package:cocktail_browser/bloc/favorite_status_event.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cocktails/bloc/search_cocktails_bloc.dart';
import 'package:search_cocktails/ui/search_cocktails_body.dart';
import 'package:search_cocktails/ui/search_text_field.dart';

import 'active_filters_view.dart';
import 'filter_panel_view.dart';

class SearchCocktailsScreen extends StatelessWidget {
  final ExecuteAdvancedSearchUseCase executeAdvancedSearchUseCase;
  final GetFilterOptionsUseCase getFilterOptionsUseCase;
  final WatchFavoritesUseCase watchFavoritesUseCase;
  final ToggleFavoriteStatusUseCase toggleFavoriteStatusUseCase;

  const SearchCocktailsScreen({
    super.key,
    required this.executeAdvancedSearchUseCase,
    required this.getFilterOptionsUseCase,
    required this.watchFavoritesUseCase,
    required this.toggleFavoriteStatusUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCocktailsBloc>(
          create:
              (context) => SearchCocktailsBloc(
                executeAdvancedSearchUseCase: executeAdvancedSearchUseCase,
                getFilterOptionsUseCase: getFilterOptionsUseCase,
              ),
        ),
        BlocProvider<FavoriteStatusBloc>(
          create:
              (context) => FavoriteStatusBloc(
                watchFavoritesUseCase: watchFavoritesUseCase,
                toggleFavoriteStatusUseCase: toggleFavoriteStatusUseCase,
              )..add(WatchFavoriteStatus()),
        ),
      ],
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
            tooltip: 'Filters',
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              context.read<SearchCocktailsBloc>().add(FilterIconTapped());
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => BlocProvider.value(
                  value: context.read<SearchCocktailsBloc>(),
                  child: const FilterPanelView(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchTextField(),
            const SizedBox(height: 8),
            ActiveFiltersView(),
            const SizedBox(height: 16),
            Text(
              'Results',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(child: SearchCocktailsBody()),
          ],
        ),
      ),
    );
  }
}