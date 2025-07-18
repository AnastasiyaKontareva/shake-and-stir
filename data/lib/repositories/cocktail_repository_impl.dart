import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:core/core.dart';

import '../entities/cocktail_details_entity.dart';
import '../entities/cocktail_entity.dart';
import '../mappers/cocktail_details_mapper.dart';
import '../mappers/cocktail_mapper.dart';
import '../providers/cache_provider.dart';
import '../providers/local_storage_provider.dart';
import '../providers/network_provider.dart';

class CocktailRepositoryImpl implements CocktailRepository {
  final Dio _dio;
  final LocalStorageProvider _localStorageProvider;
  final CacheProvider _cacheProvider;
  final ConnectivityService _connectivityService;

  CocktailRepositoryImpl({
    required NetworkProvider networkProvider,
    required LocalStorageProvider localStorageProvider,
    required CacheProvider cacheProvider,
    required ConnectivityService connectivityService,
  }) : _dio = networkProvider.dio,
       _localStorageProvider = localStorageProvider,
       _cacheProvider = cacheProvider,
       _connectivityService = connectivityService;

  @override
  Future<void> saveFavorite(CocktailDetails cocktail) async {
    final entity = CocktailDetailsMapper.toEntity(cocktail);
    await _localStorageProvider.saveFavorite(entity);
  }

  @override
  Future<void> deleteFavorite(String cocktailId) async {
    await _localStorageProvider.deleteFavorite(cocktailId);
  }

  @override
  Future<bool> isFavorite(String cocktailId) async {
    return _localStorageProvider.isFavorite(cocktailId);
  }

  @override
  Stream<List<Cocktail>> watchFavorites() {
    return _localStorageProvider.watchFavorites().map(
      (entities) =>
          entities
              .map((entity) => CocktailMapper.fromDetailsEntity(entity))
              .toList(),
    );
  }

  @override
  Future<List<Cocktail>> getCocktailsByFirstLetter(String letter) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.get(
        'search.php',
        queryParameters: {'f': letter},
      );

      final Map<String, dynamic>? data = response.data;
      if (data == null) {
        return [];
      }

      final CocktailListEntity listEntity = CocktailListEntity.fromJson(data);

      if (listEntity.drinks == null) {
        return [];
      }

      return listEntity.drinks!
          .map((entity) => CocktailMapper.toDomain(entity))
          .toList();
    } on DioException catch (e) {
      throw NetworkException('Failed to fetch cocktails: ${e.message}', e);
    } catch (e) {
      throw DataParsingException('An unexpected error occurred.', e);
    }
  }

  @override
  Future<CocktailDetails> getCocktailById(String id) async {
    try {
      if (_localStorageProvider.isFavorite(id)) {
        final favorites = _localStorageProvider.getAllFavorites();
        final localCocktail = favorites.firstWhere((c) => c.idDrink == id);
        return CocktailDetailsMapper.toDomain(localCocktail);
      }

      final cachedCocktail = _cacheProvider.getCocktail(id);
      if (cachedCocktail != null) {
        return CocktailDetailsMapper.toDomain(cachedCocktail);
      }

      final isOnline = await _connectivityService.isOnline();
      if (!isOnline) {
        throw OfflineException(
          'No internet connection. Cannot fetch new cocktails.',
        );
      }

      final response = await _dio.get('lookup.php', queryParameters: {'i': id});
      final listEntity = CocktailDetailsListEntity.fromJson(response.data);

      if (listEntity.drinks == null || listEntity.drinks!.isEmpty) {
        throw DataNotFoundException('Cocktail with ID $id not found.');
      }

      await _cacheProvider.saveCocktail(listEntity.drinks!.first);

      return CocktailDetailsMapper.toDomain(listEntity.drinks!.first);
    } on DioException catch (e) {
      throw NetworkException(
        'Failed to fetch cocktail details: ${e.message}',
        e,
      );
    } catch (e) {
      throw DataParsingException('An unexpected error occurred.', e);
    }
  }

  @override
  Future<List<Cocktail>> searchCocktailsByName(String name) async {
    try {
      final response = await _dio.get(
        'search.php',
        queryParameters: {'s': name},
      );
      final data = response.data;
      if (data == null) return [];

      final listEntity = CocktailListEntity.fromJson(data);
      if (listEntity.drinks == null) return [];

      return listEntity.drinks!
          .map((entity) => CocktailMapper.toDomain(entity))
          .toList();
    } on DioException catch (e) {
      throw NetworkException('Search failed: ${e.message}', e);
    } catch (e) {
      throw DataParsingException(
        'An unexpected error occurred during search.',
        e,
      );
    }
  }

  @override
  Future<List<Cocktail>> getAllCachedCocktails() async {
    final cachedEntities = _cacheProvider.getAllCachedCocktails();

    final cocktails =
        cachedEntities
            .map((entity) => CocktailMapper.fromDetailsEntity(entity))
            .toList();

    return cocktails;
  }

  @override
  Future<CocktailDetails> getRandomCocktail() async {
    try {
      final response = await _dio.get('random.php');
      final listEntity = CocktailDetailsListEntity.fromJson(response.data);

      if (listEntity.drinks == null || listEntity.drinks!.isEmpty) {
        throw DataNotFoundException('Could not get a random cocktail.');
      }

      final cocktailEntity = listEntity.drinks!.first;
      await _cacheProvider.saveCocktail(cocktailEntity);

      return CocktailDetailsMapper.toDomain(cocktailEntity);
    } on DioException catch (e) {
      throw NetworkException(
        'Failed to fetch random cocktail: ${e.message}',
        e,
      );
    } catch (e) {
      throw DataParsingException('An unexpected error occurred.', e);
    }
  }

  Future<List<String>> _getList(String type) async {
    try {
      final response = await _dio.get(
        'list.php',
        queryParameters: {type: 'list'},
      );
      // The API returns a list of objects like `{'strCategory': '...'}`
      final List<dynamic> drinks = response.data?['drinks'] ?? [];
      return drinks.map((item) => item.values.first as String).toList();
    } catch (e) {
      // Return empty list on failure
      return [];
    }
  }

  Future<List<Cocktail>> _filterBy(String key, String value) async {
    try {
      final response = await _dio.get(
        'filter.php',
        queryParameters: {key: value},
      );
      final listEntity = CocktailListEntity.fromJson(response.data);
      if (listEntity.drinks == null) return [];
      return listEntity.drinks!.map((e) => CocktailMapper.toDomain(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<String>> getCategories() => _getList('c');

  @override
  Future<List<String>> getGlasses() => _getList('g');

  @override
  Future<List<String>> getIngredients() => _getList('i');

  @override
  Future<List<Cocktail>> filterByIngredient(String ingredient) =>
      _filterBy('i', ingredient);

  @override
  Future<List<Cocktail>> filterByCategory(String category) =>
      _filterBy('c', category);

  @override
  Future<List<Cocktail>> executeAdvancedSearch(
    String query,
    ActiveFilters filters,
  ) async {
    List<Cocktail> initialList;
    if (query.isNotEmpty) {
      initialList = await searchCocktailsByName(query);
    } else if (filters.ingredients.isNotEmpty) {
      initialList = await filterByIngredient(filters.ingredients.first);
    } else if (filters.category != null) {
      initialList = await filterByCategory(filters.category!);
    } else {
      return [];
    }

    if (initialList.isEmpty) return [];

    final detailedCocktails = <CocktailDetails>[];
    for (final cocktail in initialList) {
      final details = await getCocktailById(cocktail.id);
      detailedCocktails.add(details);
    }

    final results =
        detailedCocktails.where((cocktail) {
          bool matches = true;
          if (filters.category != null &&
              cocktail.category != filters.category) {
            matches = false;
          }
          if (filters.glass != null && cocktail.glass != filters.glass) {
            matches = false;
          }
          if (filters.ingredients.isNotEmpty) {
            final cocktailIngredients =
                cocktail.ingredients.map((i) => i.name.toLowerCase()).toSet();
            if (!cocktailIngredients.containsAll(
              filters.ingredients.map((i) => i.toLowerCase()),
            )) {
              matches = false;
            }
          }
          return matches;
        }).toList();

    return results.map((details) {
      return Cocktail(
        id: details.id,
        name: details.name,
        thumbnailUrl: '${details.thumbnailUrl}/small',
        category: details.category,
        alcoholic: details.alcoholic,
      );
    }).toList();
  }
}
