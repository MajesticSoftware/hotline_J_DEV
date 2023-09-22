import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/view/sports/gameDetails/game_details_controller.dart';
import 'package:hotlines/theme/app_theam.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';
import 'package:hotlines/view/sports/selectSport/select_sport_screen.dart';

import 'view/sports/selectSport/selecte_game_con.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool isDarkMode = PreferenceManager.getIsDarkMode() ?? false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialBinding: BaseBindings(),
        home: SelectSportScreen());
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectGameController(), fenix: true);
    Get.lazyPut(() => GameDetailsController(), fenix: true);
    Get.lazyPut(() => GameListingController(), fenix: true);
  }
}
