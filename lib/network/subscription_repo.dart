import 'dart:developer';

import '../extras/base_api_helper.dart';
import '../extras/request_constants.dart';
import '../model/response_item.dart';

class SubscriptionRepo {
  static Future<ResponseItem> verifyReceipt(String receiptUrl) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {RequestParam.service: MethodNames.verifyReceipt};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    var param = {"receiptUrl": receiptUrl};
    try {
      result = await BaseApiHelper.postRequest(requestUrl, param, true);
      status = result.status;
      data = result.data;
      message = result.message;
    } catch (e) {
      log("Error ius ---> $e");
    }
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> manageGooglePurchase(
      String packageName, String productId, String purchaseToken) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.manageGooglePurchase
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(
        requestUrl,
        {
          'packageName': packageName,
          'productId': productId,
          'purchaseToken': purchaseToken,
        },
        true);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }



  static Future<ResponseItem> getReceiptStatus() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var queryParameters = {RequestParam.service: MethodNames.getReceiptStatus};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, {}, true);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }static Future<ResponseItem> getReleaseVersion() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var queryParameters = {RequestParam.service: MethodNames.getReleaseVersion};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, {}, false);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getGoogleCloudStatus() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var queryParameters = {
      RequestParam.service: MethodNames.googleCloudGetStatus
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, {}, true);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
