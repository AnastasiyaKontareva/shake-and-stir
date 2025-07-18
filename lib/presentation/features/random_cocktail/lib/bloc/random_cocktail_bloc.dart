import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'random_cocktail_event.dart';

part 'random_cocktail_state.dart';

class RandomCocktailBloc
    extends Bloc<RandomCocktailEvent, RandomCocktailState> {
  final GetRandomCocktailUseCase _getRandomCocktailUseCase;

  RandomCocktailBloc({
    required GetRandomCocktailUseCase getRandomCocktailUseCase,
  }) : _getRandomCocktailUseCase = getRandomCocktailUseCase,
       super(RandomCocktailState.initial()) {
    on<RandomCocktailRequested>(_onRandomCocktailRequested);
  }

  Future<void> _onRandomCocktailRequested(
    RandomCocktailRequested event,
    Emitter<RandomCocktailState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: true, clearCocktail: true, clearError: true),
    );
    try {
      final cocktail = await _getRandomCocktailUseCase.execute();
      emit(
        state.copyWith(isLoading: false, cocktail: cocktail),
      );
    } on DomainException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage:
              'Oops! Could not get a cocktail. Please check your connection.',
        ),
      );
    }
  }
}
