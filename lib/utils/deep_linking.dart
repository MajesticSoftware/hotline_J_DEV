import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:hotlines/theme/helper.dart';

import 'extension.dart';

class DeepLinkingUtils {
  void branchListenLinks() {
    FlutterBranchSdk.initSession().listen((data) async {
      log('listenDynamicLinks - DeepLink Data: $data');
      if (data.containsKey('+clicked_branch_link')) {
        if (data['+non_branch_link'] != null) {
          String link = data['+non_branch_link'];

          log("linklinklink$link");
        }
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      log('InitSession error: ${platformException.code} - ${platformException.message}');
    });
  }

  void generateLink(BuildContext context) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: BranchUniversalObject(
            title: 'Hotlines Sports',
            canonicalIdentifier: 'flutter/branch',
            canonicalUrl:
                'https://xlbkl.test-app.link?%24randomized_bundle_token=1254293642370486604'),
        linkProperties: BranchLinkProperties(
            channel: 'facebook',
            feature: 'sharing',
            stage: 'new share',
            campaign: 'campaign',
            tags: ['one', 'two', 'three']));
    if (response.success) {
      if (context.mounted) {
        shareLink(response.result,context);
      }
    } else {
      showAppSnackBar(
          'Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }
}
