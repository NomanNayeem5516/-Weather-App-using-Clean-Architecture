import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static final StorageHelper _singleton = StorageHelper._internal();

  factory StorageHelper() {
    return _singleton;
  }

  StorageHelper._internal();

  late SharedPreferences sp;
  Future<void> init() async {
    sp = await SharedPreferences.getInstance();
  }

  void clean (){sp.clear();}

  void setUserAccessToken(String token) {
    sp.setString('user_access_token', token);
  }

  String getUserAccessToken() {
    return sp.getString('user_access_token') ?? "";
  }

  void setUserLat(double lat) {
    sp.setDouble('user_lat', lat);
  }

  double getUserLat() {
    return sp.getDouble('user_lat') ?? 0.0;
  }

  void setUserLng(double lng) {
    sp.setDouble('user_lng', lng);
  }

  double getUseLng() {
    return sp.getDouble('user_lng') ?? 0.0;
  }
}
