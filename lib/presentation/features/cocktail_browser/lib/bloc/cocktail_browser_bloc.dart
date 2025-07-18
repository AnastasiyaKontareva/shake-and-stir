import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/domain.dart';
import 'package:core/core.dart';

part 'cocktail_browser_event.dart';

part 'cocktail_browser_state.dart';

class CocktailBrowserBloc
    extends Bloc<CocktailBrowserEvent, CocktailBrowserState> {
  final GetCocktailsByLetterUseCase _getCocktailsByLetterUseCase;
  final GetCachedCocktailsUseCase _getCachedCocktailsUseCase;
  final ConnectivityService _connectivityService;
  final CacheCocktailsUseCase _cacheCocktailsUseCase;

  CocktailBrowserBloc({
    required GetCocktailsByLetterUseCase getCocktailsByLetterUseCase,
    required GetCachedCocktailsUseCase getCachedCocktailsUseCase,
    required ConnectivityService connectivityService,
    required CacheCocktailsUseCase cacheCocktailUseCase,
  }) : _getCocktailsByLetterUseCase = getCocktailsByLetterUseCase,
       _getCachedCocktailsUseCase = getCachedCocktailsUseCase,
       _connectivityService = connectivityService,
       _cacheCocktailsUseCase = cacheCocktailUseCase,
       super(CocktailBrowserState.initial()) {
    on<FetchInitialListRequested>(_onFetchInitialListRequested);
    on<FetchNextPageRequested>(_onFetchNextPageRequested);
  }

  Future<void> _onFetchInitialListRequested(
    FetchInitialListRequested event,
    Emitter<CocktailBrowserState> emit,
  ) async {
    emit(state.copyWith(isInitialLoading: true, clearError: true));

    final bool isOnline = await _connectivityService.isOnline();

    if (isOnline) {
      await _fetchCocktails(emit, 'a');
    } else {
      final cachedCocktails = await _getCachedCocktailsUseCase.execute();
      emit(
        state.copyWith(
          isInitialLoading: false,
          cocktails: cachedCocktails,
          hasReachedMax: true,
        ),
      );
    }
  }

  Future<void> _onFetchNextPageRequested(
    FetchNextPageRequested event,
    Emitter<CocktailBrowserState> emit,
  ) async {
    final bool isOnline = await _connectivityService.isOnline();
    if (!isOnline || state.isPaginating || state.hasReachedMax) return;

    emit(state.copyWith(isPaginating: true));
    await _fetchCocktails(emit, state.nextLetterToFetch);
  }

  Future<void> _fetchCocktails(
    Emitter<CocktailBrowserState> emit,
    String letter,
  ) async {
    try {
      final input = GetCocktailsByLetterInput(letter: letter);
      final newCocktails = await _getCocktailsByLetterUseCase.execute(input);

      final nextCharCode = letter.codeUnitAt(0) + 1;
      final bool hasReachedMax = letter == 'z';

      emit(
        state.copyWith(
          isInitialLoading: false,
          isPaginating: false,
          cocktails: List.of(state.cocktails)..addAll(newCocktails),
          nextLetterToFetch:
              hasReachedMax ? '' : String.fromCharCode(nextCharCode),
          hasReachedMax: hasReachedMax,
        ),
      );
      _cacheCocktailsUseCase.execute(newCocktails);
    } on DomainException catch (e) {
      emit(
        state.copyWith(
          isInitialLoading: false,
          isPaginating: false,
          errorMessage: 'Failed to load more cocktails.',
        ),
      );
    }
  }
}
