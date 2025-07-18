import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cocktails/bloc/search_cocktails_bloc.dart';
import 'package:core/core.dart';

class FilterPanelView extends StatefulWidget {
  const FilterPanelView({super.key});

  @override
  State<FilterPanelView> createState() => _FilterPanelViewState();
}

class _FilterPanelViewState extends State<FilterPanelView> {
  late ActiveFilters _tempFilters;
  final _ingredientTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tempFilters = context.read<SearchCocktailsBloc>().state.activeFilters;
  }

  @override
  void dispose() {
    _ingredientTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCocktailsBloc, SearchCocktailsState>(
      builder: (context, state) {
        if (state.filterOptions == null) {
          return const Center(
            heightFactor: 3,
            child: CircularProgressIndicator(),
          );
        }
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.filterPanelTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        _buildIngredientsSection(
                          state.filterOptions!.ingredients,
                        ),
                        _buildSection(
                          AppLocalizations.of(context)!.filterPanelCategoryTitle,
                          state.filterOptions!.categories,
                          _tempFilters.category,
                          (value) {
                            setState(
                              () =>
                                  _tempFilters = _tempFilters.copyWith(
                                    category: value,
                                    clearCategory: value == null,
                                  ),
                            );
                          },
                        ),
                        _buildSection(
                          AppLocalizations.of(context)!.filterPanelGlassTypeTitle,
                          state.filterOptions!.glasses,
                          _tempFilters.glass,
                          (value) {
                            setState(
                              () =>
                                  _tempFilters = _tempFilters.copyWith(
                                    glass: value,
                                    clearGlass: value == null,
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<SearchCocktailsBloc>().add(
                              FiltersReset(),
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.filterPanelResetAllButton),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            context.read<SearchCocktailsBloc>().add(
                              FiltersApplied(_tempFilters),
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.filterPanelApplyFiltersButton),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIngredientsSection(List<String> allIngredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            AppLocalizations.of(context)!.filterPanelContainsIngredientsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return allIngredients.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          onSelected: (String selection) {
            setState(() {
              _tempFilters.ingredients.add(selection);
              _ingredientTextController.clear();
            });
            FocusScope.of(context).unfocus();
          },
          fieldViewBuilder: (
            context,
            textEditingController,
            focusNode,
            onFieldSubmitted,
          ) {
            return TextField(
              controller: _ingredientTextController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.filterPanelAddAnIngredientLabel,
                border: const OutlineInputBorder(),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        if (_tempFilters.ingredients.isNotEmpty)
          Wrap(
            spacing: 8.0,
            children:
                _tempFilters.ingredients.map((ingredient) {
                  return Chip(
                    label: Text(ingredient),
                    onDeleted: () {
                      setState(() {
                        _tempFilters.ingredients.remove(ingredient);
                      });
                    },
                  );
                }).toList(),
          ),
        const Divider(),
      ],
    );
  }

  Widget _buildSection(
    String title,
    List<String> options,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children:
              options.map((option) {
                return ChoiceChip(
                  label: Text(option),
                  selected: selectedValue == option,
                  onSelected: (selected) {
                    setState(() => onChanged(selected ? option : null));
                  },
                );
              }).toList(),
        ),
        const Divider(),
      ],
    );
  }
}
