import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST => ${options.method} ${options.path}');
    debugPrint('QUERY => ${options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE => ${response.statusCode}');
    debugPrint('DATA => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR => ${err.message}');
    super.onError(err, handler);
  }
}