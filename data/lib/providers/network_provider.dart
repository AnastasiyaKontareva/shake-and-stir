import 'package:dio/dio.dart';

class NetworkProvider {
  final Dio _dio;

  /// The base URL for the CocktailDB API.
  static const String _baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1/';

  /// Creates a NetworkProvider with a pre-configured Dio instance.
  NetworkProvider() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  /// The configured Dio instance.
  Dio get dio => _dio;
}