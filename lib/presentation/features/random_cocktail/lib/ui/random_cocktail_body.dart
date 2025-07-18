import 'package:core_ui/widgets/error_view.dart';
import 'package:core_ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_cocktail/ui/result_view.dart';
import '../bloc/random_cocktail_bloc.dart';
import 'initial_prompt_view.dart';

class RandomCocktailBody extends StatelessWidget {
  const RandomCocktailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomCocktailBloc, RandomCocktailState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingIndicator();
        }
        if (state.errorMessage != null) {
          return ErrorView(
            message: state.errorMessage,
            onRetry: () => context.read<RandomCocktailBloc>().add(RandomCocktailRequested()),
          );
        }
        if (state.cocktail != null) {
          return ResultView(cocktail: state.cocktail!);
        }
        return const InitialPromptView();
      },
    );
  }
}