import 'package:dio/dio.dart';
import 'package:news_app/core/constants/api_constants.dart';

import 'app_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(AppInterceptor());
  }
}