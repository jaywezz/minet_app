import 'package:dio/dio.dart';

// import '../../features/authentication/repository/token_storage.dart';

/// NetworkServiceInterceptor will override the onRequest method from  Dio Interceptor class
/// onRequest method will add out custom headers

class NetworkServiceInterceptor extends Interceptor {
  NetworkServiceInterceptor();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Read the access token form the secure storage
    // final accessToken =await TokenStorage().getAccessToken();

    // if (accessToken != null) {
    //   options.headers['Accept'] = 'application/json';
    //   options.headers['Content-Type'] = 'application/json';
    //   options.headers['Authorization'] = 'Bearer $accessToken';
    // } else {
    //   options.headers['Accept'] = 'application/json';
    //   options.headers['Content-Type'] = 'application/json';
    // }

    super.onRequest(options, handler);
  }
}