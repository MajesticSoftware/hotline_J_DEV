import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotlines/extras/request_constants.dart';

import '../constant/shred_preference.dart';

Map<String, String> requestHeader() {
  return {
    'X-RapidAPI-Key': dotenv.env['X-RapidAPI-Key']??"",
    'X-RapidAPI-Host': 'sportspage-feeds.p.rapidapi.com'
  };
}

Map<String, String> requestAuthHeader(bool passAuthToken) {
  return {
    RequestHeaderKey.contentType: "application/json",
    RequestHeaderKey.appSecret: "HOTLINES@2002",
    RequestHeaderKey.userAgent: "HOTLINES@2002",
    RequestHeaderKey.appTrackVersion: "v1",
    RequestHeaderKey.appDeviceType:
        '${PreferenceManager.getDeviceType() == '' ? 'iOS' : PreferenceManager.getDeviceType()}',
    RequestHeaderKey.appStoreVersion: '1.1',
    RequestHeaderKey.appDeviceModel: 'iPhone 8',
    RequestHeaderKey.appOsVersion: 'iOS 11',
    RequestHeaderKey.appStoreBuildNumber: '1.1',
    if (passAuthToken)
      RequestHeaderKey.authToken:
          '${PreferenceManager.getIsLogin() == true ? PreferenceManager.getAuthToken() : ''}',
  };
}

// ignore: deprecated_member_use
final mobileView = MediaQueryData.fromView(WidgetsBinding.instance.window);
RegExp regex = RegExp(r'([.]*0)(?!.*\d)');


