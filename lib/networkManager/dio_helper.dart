import 'package:dio/dio.dart';

import 'injection_container.dart';

class DioHelper {
  Dio dio = getDio();
  Options options = Options(
    receiveDataWhenStatusError: true,
    contentType: "application/json",
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
  );
  Map<String, dynamic> headers = {"isAuthRequest": 'Bearer token'};

  /// GET API

  Future<dynamic> get(
      {required String url, bool isAuthRequired = false}) async {
    try {
      Response response = await dio.get(url, options: options);
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// POST API

  Future<dynamic> post(
      {required String url,
      Object? requestBody,
      bool isAuthRequired = false}) async {
    if (isAuthRequired) {
      options.headers = headers;
    }
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.post(url, options: options);
      } else {
        response = await dio.post(url, data: requestBody, options: options);
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }
}
