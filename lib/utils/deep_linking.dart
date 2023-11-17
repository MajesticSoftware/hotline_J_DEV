import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:hotlines/theme/helper.dart';

import '../extras/constants.dart';

class DeepLinkingUtils {
  StreamSubscription<Map>? streamSubscriptionDeepLink;
  BranchUniversalObject? buo;
  BranchLinkProperties? lp;
  BranchResponse? response;
  void listenDeepLinkData(BuildContext context) async {
    streamSubscriptionDeepLink = FlutterBranchSdk.initSession().listen((data) {
      if (data.containsKey(AppConstants.clickedBranchLink) &&
          data[AppConstants.clickedBranchLink] == true) {
        log('LINK--${data[AppConstants.deepLinkTitle]}');
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      log('${platformException.code} - ${platformException.message}');
    });
  }

  //To Setup Data For Generation Of Deep Link
  void initializeDeepLinkData() {
    buo = BranchUniversalObject(
      canonicalIdentifier: AppConstants.branchIoCanonicalIdentifier,
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata(
            AppConstants.deepLinkTitle, AppConstants.deepLinkData),
    );
    FlutterBranchSdk.registerView(buo: buo!);

    lp = BranchLinkProperties();
    lp?.addControlParam(AppConstants.controlParamsKey, '1');
  }

  //To Generate Deep Link For Branch Io
  void generateDeepLink(BuildContext context) async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp!);
    if (response.success) {
      print(response.result);
      showAppSnackBar("${response.result}");
    } else {
      log('${response.errorCode} - ${response.errorMessage}');
    }
  }
}
