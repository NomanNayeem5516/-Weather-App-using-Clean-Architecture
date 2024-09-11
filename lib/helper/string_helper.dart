class StringHelper{
  static final StringHelper _singleton = StringHelper._internal();

  factory StringHelper() {
    return _singleton;
  }

  StringHelper._internal();
  static const String logIn='LogIn';
  static const String enterEmail='john@mail.com';
  static const String enterPassword='changeme';
  static const String location='Location';
  static const String enterPlace='Enter Place';
  static const String changeProfile='Change Profile';
}