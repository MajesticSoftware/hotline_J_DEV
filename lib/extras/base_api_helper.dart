import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' show SocketException, HttpException;

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constant/shred_preference.dart';
import '../model/response_item.dart';
import '../utils/utils.dart';
import '../view/auth/log_in_module/log_in_screen.dart';
import 'extras.dart';

class BaseApiHelper {
  static Future<ResponseItem> postRequest(String requestUrl,
      Map<String, dynamic> requestData, bool passAuthToken) async {
    printData(tittle: "request", val: requestUrl);
    printData(
        tittle: "headers:", val: requestAuthHeader(passAuthToken).toString());
    printData(tittle: "body:", val: json.encode(requestData));

    return await http
        .post(Uri.parse(requestUrl),
            body: json.encode(requestData),
            headers: requestAuthHeader(passAuthToken))
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error, requestUrl));
  }

  static Future<ResponseItem> getRequest(
      Uri requestUrl, Map<String, String> headers) async {
    printData(tittle: "request", val: requestUrl);
    final client = http.Client();
    
    try {
      // Add a timeout to prevent hanging requests
      final response = await client.get(
        requestUrl,
        headers: headers,
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('The request timed out after 15 seconds');
        },
      );
      
      ResponseItem result = await baseOnValue(response);
      return result;
    } catch (error) {
      log("API Error: $error", name: "API");
      return onError(error, requestUrl);
    } finally {
      client.close();
    }
  }

  static Future<ResponseItem> uploadFile(
      String requestUrl, Map<String, String> requestData,
      {http.MultipartFile? profileImage, bool passAuthToken = true}) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(requestUrl),
    );

    if (profileImage != null) request.files.add(profileImage);

    request.headers.addAll(requestAuthHeader(passAuthToken));
    request.fields.addAll(requestData);

    printData(tittle: "REQUEST", val: request.toString());
    // log(profileImage!.field.toString());
    printData(tittle: "body", val: json.encode(requestData));

    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse)
          .then((value) => onValue(value));
    }).onError((error, stackTrace) => onError(error, requestUrl));
  }

  static Future<ResponseItem> uploadFileWithDocument(
      String requestUrl,
      http.MultipartFile? profileImage,
      http.MultipartFile? documentFile,
      Map<String, String> requestData) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(requestUrl),
    );

    if (profileImage != null) request.files.add(profileImage);
    if (documentFile != null) request.files.add(documentFile);

    request.headers.addAll(requestHeader());
    request.fields.addAll(requestData);
    printData(tittle: "REQUEST", val: request.toString());
    printData(tittle: "body", val: json.encode(requestData));

    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse)
          .then((value) => onValue(value));
    }).onError((error, stackTrace) => onError(error, requestUrl));
  }

  static Future onValue(http.Response response) async {
    ResponseItem result;
    final ResponseItem responseData =
        ResponseItem.fromJson(json.decode(response.body));
    bool status = false;
    String message;
    String? refreshToken;

    dynamic data = responseData;

    log("responseCode: ${response.statusCode.toString()}", name: "response");
    log("fullResponse=========: ${response.body}", name: "response");

    if (response.statusCode == 200) {
      refreshToken = responseData.refreshToken!;

      message = responseData.message;
      if (responseData.status) {
        status = true;
        data = responseData.data;
        log('responseData.data---${responseData.data}');
      } else {
        printData(tittle: "logout", val: responseData.forceLogout);
        if (responseData.forceLogout!) {
          PreferenceManager.clearData();
          Get.offAll(LogInScreen());
        }
      }
    } else {
      log("response: $data");
      message = "Something went wrong.";
    }
    result = ResponseItem(
      data: data,
      message: message,
      status: status,
      refreshToken: refreshToken,
    );
    printData(
        tittle: "response",
        val:
            "data ${result.data}, message: $message, status: $status,refreshToken:$refreshToken");
    printData(
      tittle: "message",
      val: " ${result.message}",
    );

    return result;
  }

  static Future<ResponseItem> baseOnValue(http.Response response) async {
    var responseData = jsonDecode(response.body.toString());
    bool status = false;
    String message;
    var data = responseData;

    printData(tittle: "responseCode:", val: response.statusCode.toString());
    if (response.statusCode == 200) {
      message = "Ok";
      status = true;
      data = responseData;
    } else {
      printData(tittle: "Error in", val: data);
      message = "Something went wrong.";
    }
    ResponseItem result = ResponseItem(data: data, message: message, status: status);
    log("response: ${response.body}");
    printData(
        tittle: "response",
        val: "{data: ${result.data}, message: $message, status: $status}");
    return result;
  }

  static ResponseItem onError(error, url) {
    log("API Error Details: $error for URL: $url", name: "API Error");
    printData(tittle: "Error caused: ", val: error.toString());
    bool status = false;
    String message = "Unsuccessful request";
    
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is TimeoutException) {
      message = ResponseException("Request timed out. Please try again.").toString();
    } else if (error is FormatException) {
      message = ResponseException("Invalid response format.").toString();
    } else if (error is HttpException) {
      message = ResponseException("HTTP error occurred.").toString();
    } else {
      message = ResponseException("An unexpected error occurred.").toString();
    }
    
    return ResponseItem(data: null, message: message, status: status);
  }
}
