import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_structure/core/utils/logger.dart';
class AppInterceptors extends Interceptor {
  final Ref ref;  

  AppInterceptors(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.debug('Request: ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.debug('Response: ${response.statusCode} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.error('Error: ${err.message}', error: err);
    super.onError(err, handler);
  }
}