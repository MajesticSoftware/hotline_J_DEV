import 'dart:async';
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
      /*   log("IOS RESULT--${result.data[0]['ios_release_version']}");
      log("ANDROID RESULT--${result.data[0]['android_release_version']}");
      log("ANDROID RESULT--${PreferenceManager.getDeviceVersion()}");
      log("ANDROID RESULT--${PreferenceManager.getDeviceVersionNumber()}");*/
      String androidVersion =
          '${PreferenceManager.getDeviceVersion().toString().split('.').first}.${PreferenceManager.getDeviceVersion().toString().split('.')[1]}.${PreferenceManager.getDeviceVersionNumber()}';
      if ((Platform.isIOS
          ? (result.data[0]['ios_release_version'] !=
              PreferenceManager.getDeviceVersion())
          : (result.data[0]['android_release_version'] != androidVersion))) {
        return updateAppDialog();
      }
    }
  }

  Future<dynamic> updateAppDialog() {
    return showDialog(
      context: context,
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
