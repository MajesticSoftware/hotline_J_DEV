import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/view/auth/log_in_module/log_in_screen.dart';
import 'package:hotlines/view/auth/register_module/register_screen.dart';
import 'package:hotlines/view/main/app_starting_screen.dart';
import 'package:hotlines/view/sports/gameDetails/game_details_controller.dart';
import 'package:hotlines/theme/app_theam.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_screen.dart';

import 'view/sports/gameListing/game_listing_con.dart';

Future<void> main() async {
  await GetStorage.init();
  await PreferenceManager().putAppDeviceInfo();
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // bool isDarkMode = PreferenceManager.getIsDarkMode() ?? false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(810, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: PreferenceManager.getIsDarkMode() ?? false
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialBinding: BaseBindings(),
            home: PreferenceManager.getSkipLogin() == true
                ? PreferenceManager.getIsFirstLoaded() == null
                    ? const AppStartScreen()
                    : SelectGameScreen()
                : PreferenceManager.getIsLogin() == null ||
                        PreferenceManager.getIsLogin() == false
                    ? LogInScreen()
                    : PreferenceManager.getIsFirstLoaded() == null
                        ? const AppStartScreen()
                        : SelectGameScreen());
      },
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameDetailsController(), fenix: true);
    Get.lazyPut(() => GameListingController(), fenix: true);
  }
}
