import 'package:dio/dio.dart';


class ErrorHandler {
  final String message;
  final int? status;

  ErrorHandler._(this.message, this.status);

  static ErrorHandler handle(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.transformTimeout:
          return ErrorHandler._(
            'Connection timed out. Please try again.',
            statusCode,
          );

        case DioExceptionType.connectionError:
          return ErrorHandler._(
            'No internet connection. Please check your network.',
            statusCode,
          );

        case DioExceptionType.badCertificate:
          return ErrorHandler._('Security certificate error.', statusCode);

        case DioExceptionType.badResponse:
          final data = error.response?.data;

          if (data is Map) {
            final message = data['message'];

            return ErrorHandler._(
              message is String
                  ? message
                  : 'Something went wrong.',
              statusCode,
            );
          }

          return ErrorHandler._(
            'Server error. Please try again.',
            statusCode,
          );


        case DioExceptionType.cancel:
          return ErrorHandler._('Request was cancelled.', statusCode);

        case DioExceptionType.unknown:
          return ErrorHandler._(
            'Something went wrong. Please try again.',
            statusCode,
          );
      }
    }

    return ErrorHandler._('An unexpected error occurred.', null);
  }
}
