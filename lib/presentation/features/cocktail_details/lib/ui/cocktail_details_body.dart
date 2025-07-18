import 'package:core_ui/widgets/error_view.dart';
import 'package:core_ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cocktail_details_bloc.dart';

import 'details_content_view.dart';

class CocktailDetailsBody extends StatelessWidget {
  const CocktailDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocktailDetailsBloc, CocktailDetailsState>(
      builder: (context, state) {
        if (state.isLoading) return const LoadingIndicator();
        if (state.hasError) {
          return ErrorView(
            message: state.errorMessage,
            onRetry: () {
            },
          );
        }
        if (state.cocktail == null) return const Center(child: Text('Cocktail not found.'));

        return DetailsContentView(cocktail: state.cocktail!);
      },
    );
  }
}