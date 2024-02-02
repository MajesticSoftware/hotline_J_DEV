import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/shred_preference.dart';
import '../../extras/constants.dart';
import '../../generated/assets.dart';
import '../../model/response_item.dart';
import '../../network/subscription_repo.dart';
import '../../theme/app_color.dart';
import '../auth/log_in_module/log_in_screen.dart';
import '../widgets/common_dialog.dart';
import 'app_starting_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      checkReleaseVersion().then((value) {
        Get.to(
            () => PreferenceManager.getSkipLogin() ?? false
                ? (PreferenceManager.getIsFirstLoaded() == null ||
                        !PreferenceManager.getIsFirstLoaded())
                    ? const AppStartScreen()
                    : SelectGameScreen()
                : PreferenceManager.getIsLogin() ?? false
                    ? SelectGameScreen()
                    : LogInScreen(),
            duration: const Duration(milliseconds: 900));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: mobileView.size.shortestSide < 600
          ? Container(
              height: Get.height,
              width: Get.width,
              color: appColor,
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Center(
                  child: SvgPicture.asset(Assets.imagesAppLogo),
                ),
              ),
            )
          : SvgPicture.asset(
              Assets.imagesSplashImage,
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
            ),
    );
  }

  Future checkReleaseVersion() async {
    ResponseItem result = await SubscriptionRepo.getReleaseVersion();
    if (result.data != null) {
      String requiredVersion = Platform.isAndroid
          ? result.data[0]['android_release_version'].toString()
          : result.data[0]['ios_release_version'].toString();
      String requiredBuildNumber = Platform.isAndroid
          ? result.data[0]['android_release_build_num'].toString()
          : result.data[0]['ios_release_build_num'].toString();
      String v2 =requiredVersion, v1 = PreferenceManager.getDeviceVersion().toString();
      int localVersion = getExtendedVersionNumber(v1); // return 102003
      int storeVersion = getExtendedVersionNumber(v2); // return 102011
      log('localVersion--$localVersion');
      log('storeVersion--$storeVersion');
      if ((storeVersion > localVersion)||(storeVersion == localVersion&&(int.tryParse(requiredBuildNumber)??0) > (int.tryParse(PreferenceManager.getDeviceVersionNumber().toString())??0))) {
        log('Update required. Please update the app.');
        return updateAppDialog();
      } else {
        log('App is up to date or newer.');
      }
    }
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => (int.tryParse(i)??0)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  Future<dynamic> updateAppDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return exitApp(
          context,
          buttonText: '',
          isUpdateApp: true,
          title: 'New Version',
          subtitle:
              'There is a new version of the app available. please go to the app store to update',
          onTap: () {
            if (Platform.isAndroid || Platform.isIOS) {
              final appId =
                  Platform.isAndroid ? 'com.fa.app.hotlines' : '6471570051';
              final url = Uri.parse(
                Platform.isAndroid
                    ? "market://details?id=$appId"
                    : "https://apps.apple.com/app/id$appId",
              );
              launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );
            }
          },
        );
      },
    );
  }
}
