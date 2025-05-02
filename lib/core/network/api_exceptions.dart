import 'package:dio/dio.dart';

class ApiExceptions implements Exception {
  final String message;

  ApiExceptions(this.message);

  factory ApiExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ApiExceptions('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiExceptions('Send timeout');
      case DioExceptionType.receiveTimeout:
        return ApiExceptions('Receive timeout');
      case DioExceptionType.badResponse:
        return ApiExceptions._handleResponse(dioError.response!);
      case DioExceptionType.cancel:
        return ApiExceptions('Request cancelled');
      case DioExceptionType.unknown:
        return ApiExceptions('Unknown error');
      case DioExceptionType.badCertificate:
        return ApiExceptions('Bad certificate');
      case DioExceptionType.connectionError:
        return ApiExceptions('Connection error');
    }
  }

  static ApiExceptions _handleResponse(Response response) {
    switch (response.statusCode) {
      case 400:
        return ApiExceptions('Bad request');
      case 401:
        return ApiExceptions('Unauthorized');
      case 403:
        return ApiExceptions('Forbidden');
      case 404:
        return ApiExceptions('Not found');
      case 500:
        return ApiExceptions('Internal server error');
      default:
        return ApiExceptions('Something went wrong');
    }
  }

  @override
  String toString() => message;
}