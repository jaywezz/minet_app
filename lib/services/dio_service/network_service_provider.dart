import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'network_service_interceptor.dart';


/// Provide the instance of Dio
final networkServiceProvider = Provider.autoDispose<Dio>((ref) {

  final options = BaseOptions(
    baseUrl: "",
    connectTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 60),

  );

  // Add our custom interceptors
  final dio = Dio(options);

  // DANGER: THIS IS FOR DEBUGGING SSL ISSUES ONLY
  // This will bypass all SSL certificate check
  
  //  TODO: Remove this when the SSL certificate is fixed
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.interceptors.addAll([
      // HttpFormatter(),
      NetworkServiceInterceptor(),
      // if (kDebugMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    ]);

  return dio;
});