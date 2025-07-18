import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_cocktails_bloc.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});
  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCocktailsBloc, SearchCocktailsState>(
      listenWhen: (previous, current) => previous.query != current.query,
      listener: (context, state) {
        if (state.query.isEmpty && _controller.text.isNotEmpty) {
          _controller.clear();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.chipBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            icon: const Icon(Icons.search, color: AppColors.textSecondary),
            hintText: 'Search...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                context.read<SearchCocktailsBloc>().add(SearchQueryChanged(''));
              },
            ),
          ),
          onChanged: (query) {
            context.read<SearchCocktailsBloc>().add(SearchQueryChanged(query));
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}