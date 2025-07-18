import 'package:core_ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/domain.dart';

import '../bloc/cocktail_browser_bloc.dart';
import 'cocktail_grid_item.dart';
import 'cocktail_tile_item.dart';

class CocktailListView extends StatefulWidget {
  final List<Cocktail> cocktails;
  final bool hasReachedMax;
  final bool isPaginating;
  final Set<String> favoriteIds;
  final void Function(Cocktail) onFavoriteTapped;

  const CocktailListView({
    super.key,
    required this.cocktails,
    required this.hasReachedMax,
    required this.isPaginating,
    required this.favoriteIds,
    required this.onFavoriteTapped,
  });

  @override
  State<CocktailListView> createState() => _CocktailListViewState();
}

class _CocktailListViewState extends State<CocktailListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CocktailBrowserBloc>().add(FetchNextPageRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildGridView(context);
        }
        return _buildListView(context);
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount:
          widget.hasReachedMax
              ? widget.cocktails.length
              : widget.cocktails.length + 1,
      itemBuilder: (context, index) {
        if (index >= widget.cocktails.length) {
          return const LoadingIndicator(isSmall: true);
        }

        final cocktail = widget.cocktails[index];

        return CocktailGridItem(cocktail: cocktail);
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount:
          widget.hasReachedMax
              ? widget.cocktails.length
              : widget.cocktails.length + 1,
      itemBuilder: (context, index) {
        if (index >= widget.cocktails.length) {
          return widget.isPaginating
              ? const LoadingIndicator(isSmall: true)
              : const SizedBox.shrink();
        }

        final cocktail = widget.cocktails[index];
        final isFavorite = widget.favoriteIds.contains(cocktail.id);

        return CocktailTileItem(
          cocktail: cocktail,
          isFavorite: isFavorite,
          onFavoriteTapped: () => widget.onFavoriteTapped(cocktail),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
