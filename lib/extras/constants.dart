import 'package:flutter/material.dart';
import 'package:hotlines/extras/request_constants.dart';

import '../constant/shred_preference.dart';

Map<String, String> requestHeader() {
  return {
    // 'X-RapidAPI-Key': '6dd1587895msh5f0c2263a5686aap120b34jsne9263cbd71ed',
    'X-RapidAPI-Key': '08caae6c2bmsh572aebe4b01a829p14475ejsn8e6b0956f735',
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
