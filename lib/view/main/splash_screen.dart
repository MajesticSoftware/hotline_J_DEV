import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../extras/constants.dart';
import '../../generated/assets.dart';
import '../../theme/app_color.dart';
import '../sports/selectSport/select_sport_screen.dart';

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
      Get.offAll(() => SelectSportScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: modileView.size.shortestSide < 600
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
}
