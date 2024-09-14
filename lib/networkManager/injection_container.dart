import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';
import 'package:weather_app_eith_clean_arc/main.dart';

import '../screens/authScreens/login_screen.dart';
import '../utiles/print_value.dart';

Dio getDio() {
  Dio dio = Dio();
  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
    printValue(tag: 'API URL:', '${options.uri}');
    printValue(tag: 'HEADER:', '${options.headers}');
    printValue(tag: 'REQUEST BODY:', '${options.data}');
    return handler.next(options);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    printValue(tag: 'API RESPONSE:', '${response.data}');
    return handler.next(response);
  }, onError: (DioException e, handler) {
    printValue(tag: 'STATUS CODE:', '${e.response?.statusCode ?? ""}');
    printValue(tag: 'ERROR DATA:', '${e.response?.data ?? ""}');

    if (e.response?.statusCode == 401) {
      StorageHelper().clean();
      navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else if (e.response?.statusCode == 401) {}
    return handler.next(e);
  }));
  return dio;
}
