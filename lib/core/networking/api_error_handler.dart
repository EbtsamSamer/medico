import 'package:dio/dio.dart';
import 'package:medico/core/networking/api_error_model.dart';

class ApiErrorHandler {
  final String message;
  final int? status;

  ApiErrorHandler._(this.message, this.status);

  static ApiErrorHandler handle(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.transformTimeout:
          return ApiErrorHandler._(
            'Connection timed out. Please try again.',
            statusCode,
          );

        case DioExceptionType.connectionError:
          return ApiErrorHandler._(
            'No internet connection. Please check your network.',
            statusCode,
          );

        case DioExceptionType.badCertificate:
          return ApiErrorHandler._('Security certificate error.', statusCode);

        case DioExceptionType.badResponse:
          final data = error.response?.data;

          if (data is Map) {
            final apiErrorModel = ApiErrorModel.fromJson(
              Map<String, dynamic>.from(data),
            );

            return ApiErrorHandler._(
              apiErrorModel.message ?? 'Something went wrong.',
              statusCode,
            );
          }

          return ApiErrorHandler._(
            'Server error. Please try again.',
            statusCode,
          );

        case DioExceptionType.cancel:
          return ApiErrorHandler._('Request was cancelled.', statusCode);

        case DioExceptionType.unknown:
          return ApiErrorHandler._(
            'Something went wrong. Please try again.',
            statusCode,
          );
      }
    }

    return ApiErrorHandler._('An unexpected error occurred.', null);
  }
}
