import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio;

  ApiProvider()
      : dio = Dio()
    ..options.headers[AppConstants.contentTypeHeader] = AppConstants.contentType
    ..options.headers[AppConstants.apiKeyHeader] = AppConstants.apiKey;

  Dio getDio() => dio;
}