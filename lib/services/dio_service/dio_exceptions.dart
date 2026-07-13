import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(
      DioError dioError,
      ) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Connection cancelled by user";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection TimeOut";
        break;
      case DioExceptionType.receiveTimeout:

        message = "Receive Timeout";
        break;
      case DioExceptionType.connectionError:
        message = "Connection TimeOut";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response!,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "TimeOut";
        break;
      case DioExceptionType.unknown:

        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet!! Ensure You Have An Active Internet Connection';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "No internet connection";
        break;
    }
  }

  String _handleError(int? statusCode, Response error,) {
    switch (statusCode) {
      case 400:
        return error.data["message"];
      case 401:
        // if(error.realUri.path != "${UrlConstants.baseUrl}/login"){
        //   TokenStorage().removeAccessToken();
        //   showCustomSnackBar("Authentication session expired", bgColor: Colors.blue);
        // }
        return 'Unauthorized';
      case 403:
        return error.data["message"];
      case 409:
        return error.data["message"];
      case 404:
        return error.data["message"];
      case 422:
        return 'Some data is incorrect';
      case 406:
        return error.data["message"];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return error.data["message"];
    }
  }

  @override
  String toString() => message;
}