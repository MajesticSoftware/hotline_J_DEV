import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/view/demo.dart';
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
