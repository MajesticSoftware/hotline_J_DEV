import 'dart:io';

import '../extras/base_api_helper.dart';
import '../extras/request_constants.dart';
import '../model/response_item.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class UserStartupRepo {
  Future<ResponseItem> registrationRepo({
    required String fullName,
    required String email,
    required String favouriteSport,
    required String password,
    File? profileImage,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {
      "user_email": email,
      "user_password": password,
      "favourite_sport": favouriteSport,
      "user_name": fullName,
      "login_type": 'email',
    };
    http.MultipartFile image;

    var queryParameters = {RequestParam.service: MethodNames.userRegistration};

    if (profileImage != null) {
      image = http.MultipartFile(
        "user_profile_pic",
        profileImage.readAsBytes().asStream(),
        profileImage.lengthSync(),
        filename: profileImage.path.split("/").last,
        // contentType: MediaType(mimeType[0], mimeType[1]),
      );
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
      result = await BaseApiHelper.uploadFile(
          requestUrl, profileImage: image, params, passAuthToken: false);
    } else {
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
      result = await BaseApiHelper.uploadFile(requestUrl, params,
          passAuthToken: false);
    }

    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> updateUserProfile({
    required String fullName,
    required String favouriteSport,
    File? profileImage,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {
      "favourite_sport": favouriteSport,
      "user_name": fullName,
    };
    http.MultipartFile image;

    var queryParameters = {RequestParam.service: MethodNames.updateUserDetails};

    if (profileImage != null) {
      image = http.MultipartFile(
        "user_profile_pic",
        profileImage.readAsBytes().asStream(),
        profileImage.lengthSync(),
        filename: profileImage.path.split("/").last,
        // contentType: MediaType(mimeType[0], mimeType[1]),
      );
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
      result = await BaseApiHelper.uploadFile(
          requestUrl, profileImage: image, params);
    } else {
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
      result = await BaseApiHelper.uploadFile(requestUrl, params);
    }

    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> userLogin({
    required String email,
    required String password,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    String message = "";

    Map<String, String> params = {
      "user_email": email,
      "user_password": password
    };

    var queryParameters = {RequestParam.service: MethodNames.login};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> deleteAc() async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    String message = "";

    var queryParameters = {RequestParam.service: MethodNames.deleteAccount};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, {}, true);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> changePassword(
      String oldPassword, String newPassword) async {
    ResponseItem result;
    bool status = true;
    dynamic data;

    String message = "";
    String refreshToken;

    var params = {"old_password": oldPassword, "new_password": newPassword};

    var queryParameters = {
      RequestParam.service: MethodNames.changePassword,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;

    result = await BaseApiHelper.postRequest(requestUrl, params, true);
    status = result.status;
    data = result.data;
    message = result.message;
    refreshToken = result.refreshToken ?? '';

    return ResponseItem(
        data: data,
        message: message,
        status: status,
        refreshToken: refreshToken);
  }

  Future<ResponseItem> socialUserRegistration({
    required String email,
    required String socialId,
    required String loginType,
    required String fullName,
    required String authorizationCode,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    String message = "";

    Map<String, String> params = {
      "user_email": email,
      "login_type": 'apple',
      "user_name": fullName,
      "apple_social_id": socialId,
      "authorizationCode": authorizationCode
    };

    var queryParameters = {RequestParam.service: MethodNames.userRegistration};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.uploadFile(requestUrl, params,
        passAuthToken: false);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> socialUserLogin({
    required String socialId,
    required String authorizationCode,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    String message = "";

    Map<String, String> params = {
      "apple_social_id": socialId,
      "login_type": "apple",
      "authorization_code": authorizationCode
    };

    var queryParameters = {RequestParam.service: MethodNames.checkSocialLogin};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, false);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> resetPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    String message = "";

    Map<String, String> params = {
      "user_email": email,
      "verify_code": code,
      "new_password": password
    };

    var queryParameters = {
      RequestParam.service: MethodNames.changePasswordWithVerifyCode
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, false);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> forgotPassword({
    required String email,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    String message = "";

    Map<String, String> params = {
      "user_email": email,
    };

    var queryParameters = {RequestParam.service: MethodNames.forgotPassword};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> logOutApp() async {
    ResponseItem result;
    bool status = true;
    dynamic data;

    String message = "";
    String refreshToken;

    var queryParameters = {
      RequestParam.service: MethodNames.logout,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;

    result = await BaseApiHelper.postRequest(requestUrl, {}, true);
    status = result.status;
    data = result.data;
    message = result.message;
    refreshToken = result.refreshToken ?? '';

    return ResponseItem(
        data: data,
        message: message,
        status: status,
        refreshToken: refreshToken);
  }
/*  Future<ResponseItem> updateDevicePushToken(
      String pushToken,
      ) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {
      "device_push_token": pushToken,
    };

    var queryParameters = {RequestParam.service: MethodNames.updateDeviceToken};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.BASE_URL + queryString;

    result = await BaseApiHelper.postRequest(requestUrl, params, true);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }








  Future<ResponseItem> logOutApp() async {
    ResponseItem result;
    bool status = true;
    dynamic data;

    String message = "";
    String refreshToken;

    var queryParameters = {
      RequestParam.service: MethodNames.logout,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.BASE_URL + queryString;

    result = await BaseApiHelper.postRequest(requestUrl, {}, true);
    status = result.status;
    data = result.data;
    message = result.message;
    refreshToken = result.refreshToken ?? '';

    return ResponseItem(
        data: data,
        message: message,
        status: status,
        refreshToken: refreshToken);
  }*/
}
