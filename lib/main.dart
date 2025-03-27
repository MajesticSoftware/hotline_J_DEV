import 'dart:async';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/theme/app_theam.dart';
import 'package:hotlines/view/main/splash_screen.dart';
import 'package:hotlines/view/sports/gameDetails/game_details_controller.dart';
import 'package:hotlines/view/subscription/subscription_controller.dart';

import 'view/sports/gameListing/game_listing_con.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  final facebookAppEvents = FacebookAppEvents();
  facebookAppEvents.setAdvertiserTracking(enabled: true);
  await GetStorage.init();
  await PreferenceManager().putAppDeviceInfo();
  // FlutterBranchSdk.validateSDKIntegration();
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(810, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context2, child) {
        // ScreenUtil.init(context);
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: PreferenceManager.getIsDarkMode() ?? false
                ? ThemeMode.dark
                :ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialBinding: BaseBindings(),
            home: const SplashScreen());
      },
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameDetailsController(), fenix: true);
    Get.lazyPut(() => GameListingController(), fenix: true);
    Get.lazyPut(() => SubscriptionController(), fenix: true);
  }
}
