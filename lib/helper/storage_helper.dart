

import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static final StorageHelper _singleton = StorageHelper._internal();

  factory StorageHelper() {
    return _singleton;
  }

  StorageHelper._internal();

  late SharedPreferences sp;
  Future<void>init ()async{
    sp=await SharedPreferences.getInstance();
  }
  void setUserAccessToken (String token){sp.setString('user_access_token', token);}
  String getUserAccessToken (){return sp.getString('user_access_token')??"";}

}