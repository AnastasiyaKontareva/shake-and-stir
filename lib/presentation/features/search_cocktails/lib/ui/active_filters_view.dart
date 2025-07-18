import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cocktails/bloc/search_cocktails_bloc.dart';

class ActiveFiltersView extends StatelessWidget {
  const ActiveFiltersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCocktailsBloc, SearchCocktailsState>(
      buildWhen: (prev, current) => prev.activeFilters != current.activeFilters,
      builder: (context, state) {
        final filters = <Widget>[];
        final active = state.activeFilters;

        if (active.category != null) {
          filters.add(_buildChip(context, active.category!, active.category!));
        }
        if (active.glass != null) {
          filters.add(_buildChip(context, active.glass!, active.glass!));
        }
        for (final ingredient in active.ingredients) {
          filters.add(_buildChip(context, ingredient, ingredient));
        }

        if (filters.isEmpty) return const SizedBox.shrink();

        return Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) => filters[index],
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        );
      },
    );
  }

  Widget _buildChip(BuildContext context, String label, dynamic filter) {
    return Chip(
      label: Text(label),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      deleteIcon: const Icon(Icons.close, size: 16),
      onDeleted: () {
        context.read<SearchCocktailsBloc>().add(FilterRemoved(filter));
      },
    );
  }
}