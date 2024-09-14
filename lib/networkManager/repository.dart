

import '../models/auto_complite_complite.dart';
import '../models/login_model.dart';
import '../models/user_profile_model.dart';
import 'dio_helper.dart';

class Repository {
  static final DioHelper _dioHelper = DioHelper();

  static const baseUrl="https://api.escuelajs.co";

  Future<LogInModel>login(Object requestBody) async {
    Map<String,dynamic> response = await _dioHelper.post(url:'$baseUrl/api/v1/auth/login',requestBody:requestBody);
    return LogInModel.fromJson(response);
  }

  Future<AutoCompletePlaces>autoCompletePlace(String placeName) async {
    Map<String,dynamic> response = await _dioHelper.get(url:'https://geocoding-api.open-meteo.com/v1/search?name=${placeName}&count=6',);
    return AutoCompletePlaces.fromJson(response);
  }

  Future<UserProfile>userProfile() async {
    Map<String,dynamic> response = await _dioHelper.get(url:'$baseUrl/api/v1/auth/profile',isAuthRequired: true);
    return UserProfile.fromJson(response);
  }



}