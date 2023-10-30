import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';

import '../model/user_model.dart';

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

  Future<dynamic> appDeviceInfo() async {
    return Platform.isIOS
        ? await DeviceInfoPlugin().iosInfo
        : await DeviceInfoPlugin().androidInfo;
  }

  ///auth token
  static Future setAuthToken(String authToken) async {
    await getStorage.write("auth_token", authToken);
  }

  static getAuthToken() {
    return getStorage.read("auth_token");
  }

  ///user token
  static Future setUserToken(String userToken) async {
    await getStorage.write("user_token", userToken);
  }

  static getUserToken() {
    return getStorage.read("user_token");
  }

  ///userName
  static Future setUserName(String userName) async {
    await getStorage.write("userName", userName);
  }

  static getUserName() {
    return getStorage.read("userName");
  }

  ///userEmail
  static Future setUserEmail(String userEmail) async {
    await getStorage.write("userEmail", userEmail);
  }

  static getUserEmail() {
    return getStorage.read("userEmail");
  }

  ///userProfile
  static Future setUserProfile(String userProfile) async {
    await getStorage.write("userProfile", userProfile);
  }

  static getUserProfile() {
    return getStorage.read("userProfile");
  }

  ///device type
  static Future setDeviceType(String deviceType) async {
    await getStorage.write("deviceType", deviceType);
  }

  static getDeviceType() {
    return getStorage.read("deviceType");
  }

  static Future setDeviceModel(String deviceModel) async {
    await getStorage.write("deviceModel", deviceModel);
  }

  static getDeviceModel() {
    return getStorage.read("deviceModel");
  }

  static Future setDeviceVersion(String deviceVersion) async {
    await getStorage.write("deviceVersion", deviceVersion);
  }

  static getDeviceVersion() {
    return getStorage.read("deviceVersion");
  }

  ///userId
  static Future setUserId(num userId) async {
    await getStorage.write("userId", userId);
  }

  static getUserId() {
    return getStorage.read("userId");
  }

  ///userId
  static Future setFavoriteSport(String favoriteSport) async {
    await getStorage.write("favoriteSport", favoriteSport);
  }

  static getFavoriteSport() {
    return getStorage.read("favoriteSport");
  }

  static setUserData(UserData response) {
    setUserName(response.userName ?? "");
    setUserEmail(response.userEmail ?? "");
    setAuthToken(response.authToken ?? "");
    setUserToken(response.userToken ?? "");
    setUserProfile(response.userProfilePic ?? "");
    setFavoriteSport(response.favouriteSport ?? "");
    setDeviceType(Platform.isIOS ? "iOS" : "android");
    setUserId(response.userId ?? 0);
    setIsLogin(true);
  }

  putAppDeviceInfo() async {
    bool isiOS = Platform.isIOS;
    setDeviceType(isiOS ? "iOS" : "android");
    var deviceInfo = await appDeviceInfo();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (isiOS) {
      IosDeviceInfo iosDeviceInfo = (deviceInfo as IosDeviceInfo);
      setDeviceModel(iosDeviceInfo.model);
      setDeviceVersion("iOS ${iosDeviceInfo.systemVersion}");
    } else {
      AndroidDeviceInfo androidDeviceInfo = (deviceInfo as AndroidDeviceInfo);
      setDeviceVersion(androidDeviceInfo.model);
      setDeviceVersion(androidDeviceInfo.version.release);
    }
    setDeviceVersion(packageInfo.version);
  }

  static clearData() async => GetStorage().erase();
}
