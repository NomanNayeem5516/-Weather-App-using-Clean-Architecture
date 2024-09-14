import 'package:dio/dio.dart';
import 'package:weather_app_eith_clean_arc/helper/storage_helper.dart';

import 'injection_container.dart';

class DioHelper {
  Dio dio = getDio();
  Options options (bool isAuthRequired){
    if(isAuthRequired){
      return Options(
        receiveDataWhenStatusError: true,
        contentType: "application/json",
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        headers: {"Authorization": 'Bearer ${StorageHelper().getUserAccessToken()}'},
      );
    }else{
     return Options(
        receiveDataWhenStatusError: true,
        contentType: "application/json",
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
      );
    }
  }
  //Map<String, dynamic> headers = {"Authorization": 'Bearer ${StorageHelper().getUserAccessToken()}'};

  /// GET API

  Future<dynamic> get(
      {required String url, bool isAuthRequired = false}) async {

    try {
      Response response = await dio.get(url, options: options(isAuthRequired));
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

    try {
      Response response;
      if (requestBody == null) {
        response = await dio.post(url,options: options(isAuthRequired));
      } else {
        response = await dio.post(url, data: requestBody, options: options(isAuthRequired));
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }
}
