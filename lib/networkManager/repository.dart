

import '../models/login_model.dart';
import 'dio_helper.dart';

class Repository {
  static final DioHelper _dioHelper = DioHelper();

  static const baseUrl="https://api.escuelajs.co";

  Future<LogInModel>login(Object requestBody) async {
    Map<String,dynamic> response = await _dioHelper.post(url:'$baseUrl/api/v1/auth/login',requestBody:requestBody);
    return LogInModel.fromJson(response);
  }

}