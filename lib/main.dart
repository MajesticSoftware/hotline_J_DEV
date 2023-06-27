import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/theme/app_theam.dart';
import 'package:hotlines/view/main/splash_screen.dart';

import 'controller/sport_controller.dart';

Future<void> main() async {
  // await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialBinding: BaseBindings(),
        home: const SplashScreen());
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SportController(), fenix: true);
  }
}
