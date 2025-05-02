import 'package:dio/dio.dart';
import 'api_exceptions.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(url, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.fromDioError(e);
    }
  }

  Future<dynamic> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.fromDioError(e);
    }
  }
}