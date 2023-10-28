import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static Future setIsDarkMod(bool isDarkMode) async {
    await getStorage.write("isDarkMode", isDarkMode);
  }

  static getIsDarkMode() {
    return getStorage.read("isDarkMode");
  }

  static Future setIsFirstLoaded(bool isFirstLoaded) async {
    await getStorage.write("isFirstLoaded", isFirstLoaded);
  }

  static getIsFirstLoaded() {
    return getStorage.read("isFirstLoaded");
  }

  static Future setIsLogin(bool isLogin) async {
    await getStorage.write("isLogin", isLogin);
  }

  static getIsLogin() {
    return getStorage.read("isLogin");
  }

  static clearData() async => GetStorage().erase();
}
