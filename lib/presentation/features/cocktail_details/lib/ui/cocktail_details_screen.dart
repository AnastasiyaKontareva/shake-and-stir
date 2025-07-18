import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cocktail_details_bloc.dart';
import 'cocktail_details_body.dart';
import 'package:core/core.dart';

class CocktailDetailsScreen extends StatelessWidget {
  final String cocktailId;
  final GetCocktailDetailsUseCase getDetailsUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  const CocktailDetailsScreen({
    super.key,
    required this.cocktailId,
    required this.getDetailsUseCase,
    required this.isFavoriteUseCase,
    required this.toggleFavoriteUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CocktailDetailsBloc>(
      create:
          (context) => CocktailDetailsBloc(
            getDetailsUseCase: getDetailsUseCase,
            isFavoriteUseCase: isFavoriteUseCase,
            toggleFavoriteUseCase: toggleFavoriteUseCase,
          )..add(FetchDetailsRequested(cocktailId: cocktailId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.cocktailDetailsScreenTitle),
          actions: [
            BlocBuilder<CocktailDetailsBloc, CocktailDetailsState>(
              buildWhen:
                  (previous, current) =>
                      previous.isFavorite != current.isFavorite ||
                      previous.cocktail != current.cocktail,
              builder: (context, state) {
                if (state.cocktail == null) {
                  return const SizedBox.shrink();
                }
                return IconButton(
                  icon: Icon(
                    state.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    context.read<CocktailDetailsBloc>().add(FavoriteToggled());
                  },
                );
              },
            ),
          ],
        ),
        body: const CocktailDetailsBody(),
      ),
    );
  }
}
