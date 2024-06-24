import 'package:get_storage/get_storage.dart';

class AppStorage {
  static String getUser = "getUser";
  static String intro = "intro";

  static final box = GetStorage();

  static String rememberMe = "rememberMe";
  static String saveLoginId = "saveLoginInfo";
  static String saveLoginPassword = "saveLoginPassword";
  static String enableFinger = "enableFinger";
}
