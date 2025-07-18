import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_cocktail/bloc/random_cocktail_bloc.dart';
import 'package:random_cocktail/ui/random_cocktail_body.dart';
import 'package:sensors_plus/sensors_plus.dart';

class RandomCocktailScreen extends StatelessWidget {
  final GetRandomCocktailUseCase getRandomCocktailUseCase;

  const RandomCocktailScreen({
    super.key,
    required this.getRandomCocktailUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RandomCocktailBloc>(
      create:
          (context) => RandomCocktailBloc(
            getRandomCocktailUseCase: getRandomCocktailUseCase,
          ),
      child: const _RandomCocktailView(),
    );
  }
}

class _RandomCocktailView extends StatefulWidget {
  const _RandomCocktailView();

  @override
  State<_RandomCocktailView> createState() => _RandomCocktailViewState();
}

class _RandomCocktailViewState extends State<_RandomCocktailView> {
  StreamSubscription? _streamSubscription;
  bool _isSubscribed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isSubscribed && !kIsWeb) {
      _streamSubscription = accelerometerEventStream().listen((event) {
        const shakeThreshold = 15.0;
        final isShaking =
            (event.x.abs() > shakeThreshold) ||
            (event.y.abs() > shakeThreshold) ||
            (event.z.abs() > shakeThreshold);

        if (isShaking) {
          final bloc = context.read<RandomCocktailBloc>();
          if (!bloc.state.isLoading) {
            HapticFeedback.lightImpact();
            bloc.add(RandomCocktailRequested());
          }
        }
      });
      _isSubscribed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: RandomCocktailBody());
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
